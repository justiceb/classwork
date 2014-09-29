clc; clear, close all;

%given
m = 1;
K = 49;
C = 2;
k = 1;
c = 0.5;

% part (i)
%initial conditions
q1_dot_0   = 0;
q1_0       = 1;
q2_dot_0   = 0;
q2_0       = 1;

sim('ex5_model')
t = q1_sim.time;
figure(1)
plot(t,q1_sim.Data,t,q2_sim.Data)
grid on
xlabel('time (s)')
ylabel('q1 and q2')
legend('q1','q2',0)
title('ex5 part (i)')

% part (ii)
%initial conditions
q1_dot_0   = 0;
q1_0       = -1;
q2_dot_0   = 0;
q2_0       = 1;

sim('ex5_model')
t = q1_sim.time;
figure(2)
plot(t,q1_sim.Data,t,q2_sim.Data)
grid on
xlabel('time (s)')
ylabel('q1 and q2')
legend('q1','q2',0)
title('ex5 part (ii)')

% part (iii)
%initial conditions
q1_dot_0   = 0;
q1_0       = 0;
q2_dot_0   = 0;
q2_0       = 1;

sim('ex5_model')
t = q1_sim.time;
figure(3)
plot(t,q1_sim.Data,t,q2_sim.Data)
grid on
xlabel('time (s)')
ylabel('q1 and q2')
legend('q1','q2',0)
title('ex5 part (iii)')









