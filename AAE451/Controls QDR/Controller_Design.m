clc; close all; clear all
addpath FlatEarth-9.53
%addpath FlatEarth_PredatorV8.1

%boom_vec = [0.5, 1, 1.5];
boom_vec = [1];
for n = 1:1:length(boom_vec)
    
    %run Flat Earth
    format short g
    clearvars -except boom_vec xfer_vec n
    Basic_Constants_MPX5
    %Basic_Constants_PA_28_161_Improved_FLT_TEST
        Xach = Xach * boom_vec(n);
    Make_Constants  % Creates the array called constant used to define the aerodynamics and mass properties of the aircraft.
    Check_Constants % Check the constants for believability.
    Step2_Trim
    Step3_Simulate_Trim
    Step4_Plot_Trim  %(optional step)
    Step5_Simulate_Perturbations
    Step6_Plot_Perturbations  %(optional step)
    Step7_Linearize_and_Overplot
    
    %pull out Xfer function we want
    [z,p,k] = zpkdata(Lsys(3,1));  % From input "deltaE(r)" to output "q(r/s)"
    NUM = poly(z{1})*k;
    DEN = poly(p{1});
    %NUM = [-7.334 -61.79];
    %DEN = [1 11.52 22.63];
    xfer = tf(NUM,DEN)
    xfer_vec(n) = xfer;
    
    K = 0;%-3;
    [R,~] = rlocus(-xfer,-K)
    sim('Longitudinal_Stability_Model')
    t = simout.Time;
    q = simout.Data;
    figure(10)
    plot(t,q*57.2957795)
    xlabel('time (s)')
    ylabel('Pitch Rate Q (deg/s)')
    grid on
    hold all
end
%legend('0.5', '1', '1.5',0)
xfer_vec
















%{

%% T12 elevator deflection angle to pitch rate Xfer function
%                     -9.5836 s (s+5.551) (s+0.2679) (s+2.994e-05)
%   q(r/s):  ---------------------------------------------------------------
%            (s+3.412e-05) (s^2 + 0.005946s + 0.7626) (s^2 + 9.521s + 31.13)
NUM = [-9.5836,-55.7663,-14.2536,-0.000426702,0]
DEN = [9.52698,31.9495,7.4469,23.74,0.00081]
xfer = tf(-NUM,DEN)
figure(1)
rlocus(xfer)
[R,K] = rlocus(xfer,3)

K_vec = [-K, 0, K, -K];
for n = 1:1:length(K_vec)
    k = K_vec(n);
    sim('Longitudinal_Stability_Model')
    t = simout.Time;
    q = simout.Data;
    figure(3)
    plot(t,q*57.2957795)
    hold all
end
xlabel('time (s)')
ylabel('Pitch Rate Q (deg/s)')
grid on
legend('Stabilized','No Stabilization','De-stabilized',0)


%% MPX5 elevator deflection angle to pitch rate Xfer function
%                     -61.877 s (s+4.391) (s+0.199) (s+4.809e-05)
%   q(r/s):  -------------------------------------------------------------
%            (s+8.355e-05) (s^2 + 0.1098s + 0.3543) (s^2 + 12.26s + 79.86)
NUM = [-61.877,-284.018,-54.0823,-0.00260016,0]
DEN = [12.3699,81.5615,13.1192,28.2955,0.002364]
xfer = tf(-NUM,DEN)
figure(2)
rlocus(xfer)
[R,K] = rlocus(xfer,3)

k = -K;
sim('Longitudinal_Stability_Model')
t2 = simout.Time;
q2 = simout.Data;
figure(4)
plot(t,q*57.2957795,t2,q2*57.2957795)
xlabel('time (s)')
ylabel('Pitch Rate Q (deg/s)')
grid on
legend('T12 Design Stabilized','MPX5 Stabilized',0)


%}
