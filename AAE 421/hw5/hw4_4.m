clc; clear; close all;

%% Problem 4 - analytical solution
syms x1 x2 L k w m g
x1dot = x2;
x2dot = (-1/(m*L))*(k*(L*x2-w*sin(x1))*sqrt(L^2*x2^2+w^2-2*L*w*sin(x1)*x2)+m*g*sin(x1));
sol = solve(x1dot == 0, x2dot == 0);

%solve equilibrium values
x1e = (sol.x1)
x2e = (sol.x2)

%linearize
A = [diff(x1dot,x1),    diff(x1dot,x2);...
     diff(x2dot,x1),    diff(x2dot,x2)]
 
 %substitute 
subs(A,{x1,x2},{0,0})
subs(A,{x1,x2},{pi,0})

%% Problem 4 - SIMULINK solution
clear all
L = 0.1; %m
m = 0.01; %kg
g = 9.81; %m/s
CD = 0.2;
S = 0.01; %m^2
rho = 0.3809; %kg/m^3
k = rho*S*CD/2;
w = 10; %m/s
n = 0;
theta_trim = pi*n;
delta_theta0 = 3*0.0174532925; %radians
theta0 = theta_trim + delta_theta0;
theta_dot0 = 0;
t_stop = 10;%s

%use simulink model to determine trim
[Xe]=trim('hw4_4model')

%run nonlinear simulink model
sim('hw4_4model');
t_nonlin = nonlinear_simout.Time; %s
theta_nonlin = nonlinear_simout.Data(:,1);
theta_dot_nonlin = nonlinear_simout.Data(:,2);

%linearize simulink model
%[A, B, C, D] = linmod('hw4_4model');
%sys = ss(A,B,C,D);
A = [0,                              1;...
     (-1)^n*(1/(m*L))*(k*w^2-m*g),   -k*w/m]
sys = ss(A,[0,0]',[1,0],0);
[~,t_lin,X] = initial(sys,[delta_theta0, theta_dot0],t_stop);
delta_theta_lin = X(:,1);
theta_dot_lin = X(:,2);
theta_lin = delta_theta_lin + theta_trim;

%plot
figure(1)
subplot(3,1,1)
plot(t_nonlin,theta_nonlin*57.2957795,t_lin,theta_lin*57.2957795)
xlabel('time (s)')
ylabel('theta (deg)')
grid on
legend('nonlineal model','linearized model',0')
subplot(3,1,2)
plot(t_nonlin,(theta_nonlin-theta_trim)*57.2957795,t_lin,(theta_lin-theta_trim)*57.2957795)
xlabel('time (s)')
ylabel('theta (deg) - theta-equilibrium (deg)')
grid on
legend('nonlineal model','linearized model',0')
subplot(3,1,3)
plot(t_nonlin,theta_dot_nonlin*57.2957795,t_lin,theta_dot_lin*57.2957795)
xlabel('time (s)')
ylabel('theta-dot (deg/s)')
grid on
legend('nonlineal model','linearized model',0')




%%
syms x1 x2
x1dot = x2;
x2dot = (-1/(m*L))*(k*(L*x2-w*sin(x1))*sqrt(L^2*x2^2+w^2-2*L*w*sin(x1)*x2)+m*g*sin(x1));
sol = solve(x1dot == 0, x2dot == 0);

%solve equilibrium values
x1e = (sol.x1);
x2e = (sol.x2);

%linearize
A = [diff(x1dot,x1),    diff(x1dot,x2);...
     diff(x2dot,x1),    diff(x2dot,x2)];
double(subs(A,{x1,x2},{pi,0}))
