clear; clc; close all
Basic_Constants_Beech_fq;
Make_Constants;

%% User Inputs
max_dr_deg=24; %maximum rudder deflection (deg)
max_da_deg=24; %maximum aileron deflection (deg)
engine_offset=(128/2)/12; %Engine x-axis offset distance from body x-axis
gamma=0;     % flight path angle degrees
FOEI=1;
U1_min=100;
U1_max=300;
CL_max=1.4;

%% Calculations
V_stall=sqrt(2*W/(rho*CL_max*S_w));
max_dr=deg2rad(max_dr_deg);
max_da=deg2rad(max_da_deg);
[x,u,CL,CD,CM,alphadeg]=QuickTrim2(constant(58),constant(59),constant,0,0,0);
[Ftx,FyT1,Ftz,LT1,Mt,NT1]=thrust2(u,constant,constant(58),engine_offset);
FyT1=0;LT1=0;DND1=0;
NT1=FOEI*NT1;
U1=linspace(U1_min,U1_max,1000);
FQYaw2_doc

for j=1:length(U1)
    [level(j) d_dr_req(j) dr(j) da(j) phi(j)]=FQYaw2(W,rho,U1(j),S_w,b_w,constant(34),constant(35),constant(36),...
        constant(40),constant(41),constant(42),constant(51),constant(52),...
        constant(53),gamma,FyT1,LT1,NT1,DND1,max_dr,max_da);
end
figure(1)
subplot(3,1,1)
plot(U1,rad2deg(dr))
xlabel('Velocity (ft/sec)')
ylabel('Rudder Deflection (deg)')
title('Asymmetric Thrust - Rudder/Aileron Required for 0 Sideslip')
subplot(3,1,2)
plot(U1,rad2deg(da))
xlabel('Velocity (ft/sec)')
ylabel('Aileron Deflection (deg)')
subplot(3,1,3)
plot(U1,rad2deg(phi))
xlabel('Velocity (ft/sec)')
ylabel('phi (deg)')
figure(2)
plot(U1,level)
xlabel('Velocity (ft/sec)')
ylabel('Flying Quality Level')
title('Aircraft Speed vs Flying Quality Level - Asymmetric Thrust')
