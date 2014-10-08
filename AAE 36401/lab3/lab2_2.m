clc; clear; close all
addpath data

%% get constants and initial variables for sim
run ('setup_lab_ip01_2_sip')
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = 0.2;
IC_ALPHAdot0 = 0;
xcdot_0 = 0;

%% pole PLACE method and simulation
P1 = -1;
P2 = -5;
P3 = -8;
P4 = -10;
poles = [P1, P2, P3, P4]
K = place(A,B, poles)
sim('s_sip_lqr')
t = xc_out.Time;
xc = xc_out.Data;
alpha = alpha_out.Data;
figure(1)
subplot(2,1,1)
plot(t,xc)
xlabel('time (s)')
ylabel('xc (mm)')
grid on
hold all
subplot(2,1,2)
plot(t,alpha)
xlabel('time (s)')
ylabel('alpha (deg)')
grid on
hold all
figure(2)
plot(real(poles),imag(poles),'x')
xlabel('real')
ylabel('imaginary')
title('pole "place" placement method')
axis([-20 1 -1.5 1.5])

%% LQR method and simulation
R = 0.1;
q1 = 10;
q2 = 10;
q3 = 1;
q4 = 1;
Q = diag([q1, q2, q3, q4])
K = lqr(A,B,Q,R)
sim('s_sip_lqr')
t = xc_out.Time;
xc = xc_out.Data;
alpha = alpha_out.Data;
figure(1)
subplot(2,1,1)
plot(t,xc)
xlabel('time (s)')
ylabel('xc (mm)')
legend('place method','LQR method')
grid on
hold all
subplot(2,1,2)
plot(t,alpha)
xlabel('time (s)')
ylabel('alpha (deg)')
legend('place method','LQR method')
grid on
hold all

poles = eig(A-B*K)
figure(3)
plot(real(poles),imag(poles),'x')
xlabel('real')
ylabel('imaginary')
title('LQR method pole placement')
axis([-20 1 -1.5 1.5])

%% Experimental data
load('part2_2_place_andrew')
i0 = 13790;
iend = i0 + 2800;
t = simout.time(i0:iend);
    t = t - t(1);
alpha = -simout.signals.values(i0:iend,2)*57.2957795;
xc = -simout.signals.values(i0:iend,1) - 0.090558;
figure(1)
subplot(2,1,1)
plot(t,xc)
subplot(2,1,2)
plot(t,alpha)
hold all

load('part2_2_lqr_brent')
i0 = 11780;
iend = i0 + 3000;
t = simout.time(i0:iend);
    t = t - t(1);
alpha = -simout.signals.values(i0:iend,2)*57.2957795 + 1.9;
xc = -simout.signals.values(i0:iend,1) - 0.04127;
figure(1)
subplot(2,1,1)
plot(t,xc)
legend('SIM - place method','SIM - LQR method','EXP - place method','EXP - LQR method')
subplot(2,1,2)
plot(t,alpha)
xlim([0,3])
legend('SIM - place method','SIM - LQR method','EXP - place method','EXP - LQR method')
hold all




