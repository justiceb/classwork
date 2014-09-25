clc; clear; close all
addpath code
addpath data

%% Part 3
%initialize variables
run setup_lab_ip02_spg

%part a: simulink
Ai = [A, zeros(4, 1);-1, 0, 0, 0, 0];
Bi = [B; 0];
p3 = -10;
p4 = -20;
p5 = -30;
K = place (Ai,Bi,[(-1.8182+1.9067i), (-1.8182-1.9067i), p3, p4, p5])
sim('aae364gantry2')
t_sim = alpha_out.Time;
theta_sim = alpha_out.Data;      %deg
xc_sim = xc_out.Data;  %m
figure(1)
subplot(2,1,1)
plot(t_sim,theta_sim)
xlabel('time (s)')
ylabel('angle (degrees)')
grid on
subplot(2,1,2)
plot(t_sim,xc_sim)
xlabel('time (s)')
ylabel('cart position (m)')
grid on
theta_properties_sim = stepinfo([0;theta_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
xc_properties_sim = stepinfo([0;xc_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)

%part b: experimental
load('part_4_theta_drake')
load('part_4_x_drake')
t = theta.time(1:end/2);
t = t - t(1);
theta = theta.signals.values(1:end/2)*57.2957795;
xc = x.signals.values(1:end/2);

K = [112.4296, -28.2173, 31.3039, 8.9735, -134.139]
sim('aae364gantry2')
t_sim = alpha_out.Time;
theta_sim = alpha_out.Data;      %deg
xc_sim = xc_out.Data;  %m
figure(2)
subplot(2,1,1)
plot(t_sim,theta_sim,t,theta)
legend('SIMULINK','experimental',0)
xlabel('time (s)')
ylabel('angle (degrees)')
grid on
subplot(2,1,2)
plot(t_sim,xc_sim,t,xc)
legend('SIMULINK','experimental',0)
xlabel('time (s)')
ylabel('cart position (m)')
grid on
theta_properties_sim = stepinfo([0;theta_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
xc_properties_sim = stepinfo([0;xc_sim],[0;t_sim],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
theta_properties = stepinfo([0;theta],[0;t],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
xc_properties = stepinfo([0;xc],[0;t],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
