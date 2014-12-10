% Step4_Plot_Noninear_Sim.m   Version 8.0 1/23/03
% 
% OBJECTIVE: Plot results from the nonlinear flat earth simulation.
%
% INPUTS: In the Matlab workspace must be an array of simulation times (taircraft)
%         and a matrix of simulation outputs (yaircraft). These are generally
%         created by the SIMULINK simulations FlatEarth_MATLABx.mdl.
% OUTPUTS: Four figures, each with three subplots.

disp(' ');disp('Start here');disp(' ');
input='Time History Plots';
figure(1)
subplot(311)
plot(taircraft,yaircraft(:,5))
xlabel('time (sec)')
ylabel('Q (rad/sec)')
title(input)

subplot(312)
plot(taircraft,yaircraft(:,8))
xlabel('time (sec)')
ylabel('theta (rad)')

subplot(313)
plot(taircraft,yaircraft(:,14))
xlabel('time (sec)')
ylabel('alpha (rad)')

figure(2)
subplot(311)
plot(taircraft,yaircraft(:,6))
xlabel('time (sec)')
ylabel('R (rad/sec)')
title(input)

subplot(312)
plot(taircraft,yaircraft(:,9))
xlabel('time (sec)')
ylabel('psi (rad)')

subplot(313)
plot(taircraft,yaircraft(:,15))
xlabel('time (sec)')
ylabel('beta (rad)')

figure(3)
subplot(311)
plot(taircraft,yaircraft(:,4))
xlabel('time (sec)')
ylabel('P (rad/sec)')
title(input)

subplot(312)
plot(taircraft,yaircraft(:,7))
xlabel('time (sec)')
ylabel('phi (rad)')

subplot(313)
plot(taircraft,yaircraft(:,11))
xlabel('time (sec)')
ylabel('Y (ft)')

figure(4)
subplot(311)
plot(taircraft,deltaE)
xlabel('time (sec)')
ylabel('Elevator (rad)')
title(input)

subplot(312)
plot(taircraft,deltaA)
xlabel('time (sec)')
ylabel('Aileron (rad)')

subplot(313)
plot(taircraft,deltaR)
xlabel('time (sec)')
ylabel('Rudder (rad)')
