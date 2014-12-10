function [level d_dr]=FQYaw1(W,rho,U1,S_w,b_w,Cyb,Cyda,Cydr,Clb,Clda,Cldr,Cnb,Cnda,Cndr,gamma,FyT1,LT1,NT1,DND1,max_dr,flag,class)
%[level]=FQYaw1(W,rho,U1,S_w,b_w,Cyb,Cyda,Cydr,Clb,Clda,Cldr,Cnb,Cnda,Cndr,
%gamma,FyT1,LT1,NT1,DND1,max_dr,flag,class)
%Calculate required rudder and aileron for straight flight with sideslip in
%a crosswind. With plots enabled, rudder deflection, aileron deflection, 
%and phi vs Beta and Crosswind Velocity plots are created. This function 
%returns the flying qualities level as defined in MIL-F-8785c.
% References
% [1] Roskam, Jan. "Airplane Flight Dynamics and Automatic Flight Controls", 
%     DARcorporation Lawrence, KS Second Printing, 1998.
% 
% [2] Roskam, Jan. “Airplane Design: Part VII Determination of Stability, 
%                  Control, and Performance Characteristics: 
%                  FAR and Military Requirements. DARcorporation. Lawrence, KS, 2002.
% 
% [3] Raymer, Daniel P. “Aircraft Design: A Conceptual Approach” AIAA 
%                       Education Series. Reston, VA Fourth Edition, 2006.
% 
% [4] Anon.; MIL-F-8785c, Military Specification Flying Qualities of 
%            Piloted Airplanes; November 5, 1980; Air Force Flight 
%            Dynamics Laboratory, WPAFB, Dayton, OH.
% 
% [5] Anon.; MIL-STD-1797A, Flying Qualities of Piloted Aircraft; 
%            January 30, 1990; Air Force Flight Dynamics 
%            Laboratory, WPAFB, Dayton, OH.
%
% W - Aircraft weight (lbs)
% rho - air density slugs/ft^3
% U1 - Trim Flight Speed (ft/sec)
% S_w - Reference Wing Area (ft^2)
% b_w - Reference Wing Chord (ft)
% Cyb - Variation of airplane side force coefficient with dimensionless rate
%      of change of angle of sideslip (1/rad)
% Cyda - Variation of side force coefficient with aileron angle (1/rad)
% Cydr - Variation of side force coefficient with rudder angle (1/rad)
% Clb - Variation of rolling moment coefficient with angle of sideslip
%       (1/rad)
% Clda - Variation of rolling moment coefficient with aileron angle (1/rad)
% Cldr - Variation of rolling moment coefficient with rudder angle (1/rad)
% Cnb - Variation of yawing moment coefficient with angle of sideslip(1/rad)
% Cnda - Variation of yawing moment coefficient with aileron angle (1/rad)
% Cndr - Variation of yawing moment coefficient with rudder angle (1/rad)
% gamma - Flight Path Angle (deg)
% LT1 - Moment due to Thrust about X (ft-lbf);
% NT1 - Moment due to Thrust about Z (ft-lbf);
% FyT1 - Thrust Force Component along Y (ft-lbf);
% DND1 - Additional yawing moment due to drag from failed engine 
%   NOTE: The contribution of DND1 may be estimated by using NT1=FOEI*NT1
%         and setting DND1=0. See table below [Roskam]
%Type of Power Plant    Fixed Pitch  Variable Pitch    Low BPR     High BPR
%FOEI                       1.25          1.10           1.15         1.25
%max_dr - Maximum Rudder Deflection (Degrees)
%flag - Plot Flag. flag = 1 - Output Plots flag =0 Do not output plots
%class - Airplane class
%For Airplane Class     I    use class = 1;
%                       II-L use class = 21;
%                       II-C use class = 22;
%                       III  use class = 3;
%                       IV   use class = 4;
gamma=deg2rad(gamma);
if class==1
    max_cross=20; %knots
elseif class==21 ||class==22 || class==3 ||class==4
    max_cross=30; %knots
end
max_beta_req=rad2deg(asin(max_cross/U1/.5925)); %Maximum Beta Required for Level 1

nbeta=60;
beta_range=linspace(0,max_beta_req,nbeta);
%
% Problem statement
% Given beta, find phi(deg), da(deg) and dr(deg)
% x=sin(phi),da,dr
% Ax=B
%
% Set up dimensions
%
BETA=zeros(1,nbeta);
DA=zeros(1,nbeta);
DR=zeros(1,nbeta);
PHI=zeros(1,nbeta);
%xwindkn=zeros(1,nbeta);
%
% Compute intermediate items
%
qbar=.5*rho*U1*U1;
U1knots=U1*.5925; % knots

for i=1:length(beta_range)
    beta=deg2rad(beta_range(i));
    a1=[W*cos(gamma)/(qbar*S_w), 0, 0]';
    a2=[Cyda, Clda, Cnda]';
    a3=[Cydr, Cldr, Cndr]';
    A=[a1 a2 a3];
    B=[-Cyb*beta-FyT1/(qbar*S_w); -Clb*beta-LT1/(qbar*S_w*b_w); -Cnb*beta-(NT1-DND1)/(qbar*S_w*b_w)];
    x=inv(A)*B;
	PHI(i)=asin(x(1));
	DA(i)=x(2);
	DR(i)=x(3);
	BETA(i)=beta;
end
xwindkn=sin(BETA)*U1*.5925;
level1_rudder_def=interlim1(xwindkn,DR,max_cross);
level3_rudder_def=interlim1(xwindkn,DR,max_cross/2);

if max_dr>=level1_rudder_def
    level=1;
    d_dr=rad2deg(level1_rudder_def-max_dr); %Extra Rudder Def. Reqd for Level 1
elseif max_dr<level1_rudder_def && max_dr>=level3_rudder_def
    d_dr=rad2deg(level1_rudder_def-max_dr); %Extra Rudder Def. Reqd for Level 1
    level=3;
elseif max_dr<level3_rudder_def
    d_dr=rad2deg(level1_rudder_def-max_dr); %Extra Rudder Def. Reqd for Level 1
    level=0;
end

if flag==1
    %
    % Plot results vs beta
    %
    BETA=rad2deg(BETA);
    PHI=rad2deg(PHI);
    DA=rad2deg(DA);
    DR=rad2deg(DR);
    figure(1)
    subplot(3,1,1)
    plot(BETA,DR)
    heading=['Landing in a crosswind, U1= ',num2str(U1knots),' knots, right sideslip (beta+)'];
    title(heading)
    ylabel('rudder (deg)')
    %
    subplot(3,1,2)
    plot(BETA,DA)
    ylabel('aileron (deg)')
    %
    subplot(3,1,3)
    plot(BETA,PHI)
    ylabel('phi (deg)')
    xlabel('beta (deg)')
    %
    % Plot results vs crosswind velocity in knots
    %
    figure(2)
    subplot(3,1,1)
    plot(xwindkn,DR)
    title(heading)
    xlabel('crosswind (knots)')
    ylabel('rudder (deg)')
    %
    subplot(3,1,2)
    plot(xwindkn,DA)
    xlabel('crosswind (knots)')
    ylabel('aileron (deg)')
    %
    subplot(3,1,3)
    plot(xwindkn,PHI)
    xlabel('crosswind (knots)')
    ylabel('phi (deg)')
end

return
