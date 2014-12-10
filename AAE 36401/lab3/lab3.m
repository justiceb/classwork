clc; clear; close all
addpath data

%% Simulation results
clc; clear; close all;

run ('setup_lab_ip01_2_sip')
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = 0;
IC_ALPHAdot0 = 0;
xcdot_0 = 0;
Ai = [A, zeros(4, 1);-1, 0, 0, 0, 0];
Bi = [B; 0];

R = 0.1;
q1 = 1;
q2 = 1;
q3 = 0;
q4 = 0;
q5 = 10;
K = lqr(Ai,Bi, diag([q1, q2, q3, q4, q5]),R)
sim('aae364pinv2')
t = xc_out.Time;
xc = xc_out.Data;
xc_cmd = xc_cmd_out.Data;
angle = angle_out.Data;
figure(1)
subplot(2,1,1)
plot(t,xc,t,xc_cmd)
xlabel('time (s)')
ylabel('xc (mm)')
legend('xc response','xc input')
grid on
hold all
subplot(2,1,2)
plot(t,angle)
xlabel('time (s)')
ylabel('angle (deg)')
grid on
hold all

%% experimental data
load('part3_brent')
i0 = 7684;
iend = i0+6900;
t = simout.time(i0:iend);
    t = t - t(1);
alpha = simout.signals.values(i0:iend,2)*57.2957795;
    alpha = alpha - alpha(1);
alphadot = simout.signals.values(i0:iend,4)*57.2957795;
xc = simout.signals.values(i0:iend,1);
    xc = xc - xc(1);
xcdot = simout.signals.values(i0:iend,3);
xc_cmd = simout.signals.values(i0:iend,5);
figure(1)
subplot(2,1,1)
plot(t,xc,t,xc_cmd)
xlim([0 14]);
legend('SIM - xc response','SIM - xc input','EXP - xc response','EXP - xc input')
hold all
subplot(2,1,2)
plot(t,alpha)
legend('SIM response','EXP response')
xlim([0 14]);
hold all

%% plot poles
poles = eig(Ai-Bi*K)
figure(3)
plot(real(poles),imag(poles),'x')
xlabel('real')
ylabel('imaginary')
title('LQR method pole placement')
axis([-16 1 -1.5 1.5])



