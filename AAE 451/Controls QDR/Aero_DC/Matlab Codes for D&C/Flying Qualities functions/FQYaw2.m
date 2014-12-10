function [level d_dr dr da phi]=FQYaw2(W,rho,U1,S_w,b_w,Cyb,Cyda,Cydr,Clb,Clda,Cldr,Cnb,Cnda,Cndr,gamma,FyT1,LT1,NT1,DND1,max_dr,max_da)
%[level]=FQYaw1(W,rho,U1,S_w,b_w,Cyb,Cyda,Cydr,Clb,Clda,Cldr,Cnb,Cnda,Cndr,
%gamma,FyT1,LT1,NT1,DND1,max_dr,max_da)
%Calculate required rudder and aileron for zero sideslip in an asymmetric
%thrust situation. 
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
%W - Aircraft weight (lbs)
%rho - air density slugs/ft^3
%U1 - Trim Flight Speed (ft/sec)
%S_w - Reference Wing Area (ft^2)
%b_w - Reference Wing Chord (ft)
%Cyb - Variation of airplane side force coefficient with dimensionless rate
%      of change of angle of sideslip (1/rad)
%Cyda - Variation of side force coefficient with aileron angle (1/rad)
%Cydr - Variation of side force coefficient with rudder angle (1/rad)
%Clb - Variation of rolling moment coefficient with angle of sideslip
%       (1/rad)
%Clda - Variation of rolling moment coefficient with aileron angle (1/rad)
%Cldr - Variation of rolling moment coefficient with rudder angle (1/rad)
%Cnb - Variation of yawing moment coefficient with angle of sideslip(1/rad)
%Cnda - Variation of yawing moment coefficient with aileron angle (1/rad)
%Cndr - Variation of yawing moment coefficient with rudder angle (1/rad)
%gamma - Flight Path Angle (deg)
%LT1 - Moment due to Thrust about X (ft-lbf);
%NT1 - Moment due to Thrust about Z (ft-lbf);
%FyT1 - Thrust Force Component along Y (ft-lbf);
%DND1 - Additional yawing moment due to drag from failed engine 
%   NOTE: The contribution of DND1 may be estimated by using NT1=FOEI*NT1
%         and setting DND1=0. See table below [Roskam]
%Type of Power Plant    Fixed Pitch  Variable Pitch    Low BPR     High BPR
%FOEI                       1.25          1.10           1.15         1.25
%max_dr - Maximum Rudder Deflection (Degrees)
%max_da - Maximum Aileron Deflection (Degrees)
gamma=deg2rad(gamma);

beta=0; %Must maintain 0 sideslip w/ asymmetric thrust
%
% Problem statement
% Given beta, find phi(deg), da(deg) and dr(deg)
% x=sin(phi),da,dr
% Ax=B
%
% Compute intermediate items
%
qbar=.5*rho*U1*U1;


a1=[W*cos(gamma)/(qbar*S_w), 0, 0]';
a2=[Cyda, Clda, Cnda]';
a3=[Cydr, Cldr, Cndr]';
A=[a1 a2 a3];
B=[-Cyb*beta-FyT1/(qbar*S_w); -Clb*beta-LT1/(qbar*S_w*b_w); -Cnb*beta-(NT1-DND1)/(qbar*S_w*b_w)];
x=inv(A)*B;
phi=asin(x(1));
da=x(2);
dr=x(3);

if abs(dr)<abs(max_dr) && abs(da)<abs(max_da)
    level=1;
    d_dr=rad2deg(dr-max_dr); %Extra Rudder Def. Reqd for Level 1
    d_da=rad2deg(da-max_da); %Extra Aileron Def. Reqd for Level 1
else
    level=3;
    d_dr=rad2deg(dr-max_dr); %Extra Rudder Def. Reqd for Level 1
    d_da=rad2deg(da-max_da); %Extra Aileron Def. Reqd for Level 1
end