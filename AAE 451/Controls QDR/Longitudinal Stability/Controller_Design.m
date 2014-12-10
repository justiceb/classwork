clc; close all

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



