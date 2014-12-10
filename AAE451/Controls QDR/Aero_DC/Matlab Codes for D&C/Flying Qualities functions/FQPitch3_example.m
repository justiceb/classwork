clear all;clc;close all
Basic_Constants_MPX5;
Make_Constants
%% User Inputs
de_deg=-20;
CL_max=1.2;
class=1;             %Aircraft class
gear_type=2;         %Gear Type = 1 Tricycle 
                     %Gear Type = 2 Taildragger
ground_roll_angle=10; %taildragger taildown angle (deg) usually located at 
                      %angle of attack of stall at landing 10-15 deg
                      %Tricyle gear should be ~=0 deg
mu_wg=.02; %Coefficient of friction wheel-concrete
z_cg=.39; %Landing Gear height above ground (ft)
x_mg_rot=.2;  %Distance from leading edge of wing to main gear (ft)
z_d=.39; %Resultant Drag vertical distance above ground
z_t=.39; %Engine thrust vertical distance from ground
bhp_max=.1;     %Max bhp
%% Calculations
V_stall=sqrt(2*W/(rho*CL_max*S_w));
U1_des=V_stall;  %Desired speed to achieve rotation
de=deg2rad(de_deg);  %Elevator deflection
U_takeoff=V_stall*1.1;

U1_vec=[U_takeoff];
de=deg2rad(-20:.01:20);
%de=deg2rad(-20);
g=constant(2);
set(gca,'ColorOrder',[0 0 1;0 1 0;1 0 1;1 0 0;0 1 1;1 1 0])

%set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
%      'DefaultAxesLineStyleOrder','-|--|:')

for k=1:length(U1_vec)
    U1=U1_vec(k);
    CL_alpha_w= 2*pi*(AR_w)/ (2+sqrt((AR_w*beta/kappa)^2*(1+(tan(Lambda_c2))^2/beta^2)+4 ));
    CL_alpha_h=2*pi*AR_h/(2+sqrt((AR_h*beta/kappa_h)^2*(1+(tan(Lambda_c2_h))^2/beta^2)+4 )); 
    [CL_0_t CL_0_h CL_0_wf]=CL_0(S_w,S_h,M,tc_w,alpha_0,epsilon_t,i_w,i_h,epsilon_0_h,AR_w...
    ,Lambda_c4,Lambda_c2,Lambda_c2_h,lambda_w,kappa,kappa_h,beta,b_w,d,AR_h,eta_h);  % CL0
    CL_de_h=constant(30);
    Make_Constants_2
    FQPitch3_doc
    for j=1:length(de)
        [React(k,j) U_dot(k,j) theta_dotdot_mg(k,j) level(k,j)]=FQPitch3(CL_0_h, CL_0_wf, CL_alpha_h, CL_de_h, bhp_max,de(j),...
            rho, Cd, CL_alpha_w, constant(45), constant(46), constant(47),...
            ground_roll_angle,U1_vec(k), S_w, S_h,x_m, Xref, Xcg, W, c_w, mu_wg, g, constant(8),...
            z_cg, Iyy, Xacwb, Xach, x_mg_rot, z_d, z_t, i_w,i_h,class,gear_type);
    end

end
level_max_de=level(1,length(de));
angular_accel_max_de=min(theta_dotdot_mg(1,:));
plot(rad2deg(de),theta_dotdot_mg(1,:))
xlabel('Elevator Deflection (deg)')
ylabel('$$\ddot \theta (deg/s^2)$$','fontsize',12,'interpreter','latex');
fig1_title=({['Angular Acceleration vs Elevator Deflection'];['V=.5*V_t_a_k_e_o_f_f'];...
    ['FQ Level =' num2str(level_max_de)];['Maximum ang. acc. =' num2str(angular_accel_max_de) ' deg/sec^2']});
title(fig1_title)