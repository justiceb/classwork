clc; clear; close all
addpath code
addpath data

%% Part 3
%initialize variables
run setup_lab_ip02_spg

%part a: simulink with adot = pi/2
p3 = -10
p4 = -20
K = place (A,B,[(-1.8182+1.9067i), (-1.8182-1.9067i), p3, p4])
X0 = [0, 0, 0, pi/2]';                
sim('s_spg_pp')
t_sim = alpha_out.Time;
theta_sim = alpha_out.Data;      %deg
xc_sim = xc_out_mm.Data * 0.001;  %m
theta_properties_sim = stepinfo([0;theta_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)

figure(1)
subplot(2,1,1)
plot(t_sim,theta_sim)
xlabel('time (s)')
ylabel('angle (deg)')
grid on
title('initial angluar velocity = pi/2 rad/s')
subplot(2,1,2)
plot(t_sim,xc_sim)
xlabel('time (s)')
ylabel('cart position (m)')
grid on

%part b: experimental results
load('part_3_theta_brent')
load('part_3_x_brent')
t = theta.time(1:end/2);
t = t - t(1) - 0.4;
theta = theta.signals.values(1:end/2)*57.2957795;
xc = x.signals.values(1:end/2);

%part c: find max slope
[Y,I] = max(diff(theta))
max_slope = Y/(t(I+1) - t(I))   %deg/s

%part c: sim results with same initial velocity
X0 = [0, 0, 0, max_slope*0.0174532925]';                
sim('s_spg_pp')
t_sim = alpha_out.Time;
theta_sim = alpha_out.Data;      %deg
xc_sim = xc_out_mm.Data * 0.001;  %m
theta_properties = stepinfo([0;theta],[0;t],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
theta_properties_sim = stepinfo([0;theta_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)

figure(2)
subplot(2,1,1)
plot(t_sim,theta_sim,t,theta,t(I),theta(I),'o')
legend('SIMULINK','experimental','max experimental slope',0)
xlabel('time (s)')
ylabel('angle (deg)')
grid on
title('initial angluar velocity provided by user push')
subplot(2,1,2)
plot(t_sim,xc_sim,t,xc)
legend('SIMULINK','experimental',0)
xlabel('time (s)')
ylabel('cart position (m)')
grid on






