clear all;clc;close all
Basic_Constants_MPX5;
%% User Defined
CL_max=1.4; %CLmax
sim_run_time=5; %Simulation run time
de_deg=20;  %Maximum elevator deflection (deg)

%% Calculations
de=deg2rad(de_deg); %calculate elevator deflection in radians
rho=rhofun(0); %air density
V_stall=sqrt(2*W/(rho*CL_max*S_w)); %Stall speed
U1 = V_stall;
U = U1/1.687808; %Stall speed in knots
Make_Constants;
%Initialize accelerometer locations to zero for linearization
Xa(1)=0; % x-location of accelerometer wrt c.g. (ft)
Xa(2)=0; % y-location of accelerometer wrt c.g. (ft)
Xa(3)=0; % z-location of accelerometer wrt c.g. (ft)



[xIC,uIC,CL,CD,CM,alphadeg]=QuickTrim2(constant(58),constant(59),constant,0,0,0);
Linearize_MATLAB7_min;
[a1,b1,c1,d1]=selector(aL,bL,cL,dL,[2 3],1,[3 7]);
short_period_sys=ss(a1,b1,c1,d1);
FQPitch2_doc
[q_sim t_sim1 alpha_sim t_sim2 level]=FQPitch2(de,short_period_sys,y1,sim_run_time);

figure
fig1_title=({['Pitch Rate vs Time - Step Input Elevator'];['FQ Level =' num2str(level)]});
plot(t_sim1,rad2deg(q_sim))
title(fig1_title)
xlabel('Time (sec)')
ylabel('Pitch Rate (deg/sec)')
figure
plot(t_sim2,rad2deg(alpha_sim))
title('AoA vs Time - Step Input Elevator')
xlabel('Time (sec)')
ylabel('\alpha (deg)')