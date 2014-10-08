clc; clear; close all
addpath data
run ('setup_lab_ip01_2_sip')

%% Load lqr data
load('part2_lqr_brent')
i0 = 4495;
tend = 4; %s
t = simout.time(i0:end);
    t = t - t(1);
alpha = -simout.signals.values(i0:end,2)*57.2957795;
alphadot = -simout.signals.values(i0:end,4)*57.2957795;
xc = -simout.signals.values(i0:end,1) + 0.0314;
xcdot = -simout.signals.values(i0:end,3);
figure(1)
subplot(2,2,1)
plot(t,xc)
xlabel('time (s)')
ylabel('xc (mm)')
grid on
hold all
xlim([0 tend])
subplot(2,2,2)
plot(t,xcdot)
xlabel('time (s)')
ylabel('xcdot (mm/s)')
grid on
hold all
xlim([0 tend])
subplot(2,2,3)
plot(t,alpha)
xlabel('time (s)')
ylabel('alpha (deg)')
grid on
hold all
xlim([0 tend])
subplot(2,2,4)
plot(t,alphadot)
xlabel('time (s)')
ylabel('alphadot (deg/s)')
grid on
hold all
xlim([0 tend])

%% sim lqr conditions
[alphadot_start,Istart] = min(alphadot(1:1000));
alphadot_start = alphadot(Istart);
alpha_start = alpha(Istart);
xcdot_start = xcdot(Istart);
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = alpha_start*0.0174532925; %rads
IC_ALPHAdot0 = alphadot_start*0.0174532925; %rads/s
xcdot_0 = xcdot_start; %mm/s
R = 0.1;
q1 = 10;
q2 = 10;
q3 = 1;
q4 = 1;
Q = diag([q1, q2, q3, q4]);
K = lqr(A,B,Q,R);
sim('s_sip_lqr')
t = xc_out.Time + 0.236;
xc = xc_out.Data;
xcdot = xcdot_out.Data;
alpha = alpha_out.Data;
alphadot = alphadot_out.Data;
    alphadot(1) = alphadot(2);

figure(1)
subplot(2,2,1)
plot(t,xc)
legend('EXP - lqr method','SIM - lqr method')
hold all
subplot(2,2,2)
plot(t,xcdot)
legend('EXP - lqr method','SIM - lqr method')
hold all
subplot(2,2,3)
plot(t,alpha)
legend('EXP - lqr method','SIM - lqr method')
hold all
xlim([0 tend])
subplot(2,2,4)
plot(t,alphadot)
legend('EXP - lqr method','SIM - lqr method')
hold all

%% Load PLACE data
load('part2_place_andrew')
i0 = 7250;
tend = 4; %s
t = simout.time(i0:end);
    t = t - t(1);
alpha = -simout.signals.values(i0:end,2)*57.2957795;
alphadot = -simout.signals.values(i0:end,4)*57.2957795;
xc = -simout.signals.values(i0:end,1) + 0.081;
xcdot = -simout.signals.values(i0:end,3);
figure(2)
subplot(2,2,1)
plot(t,xc)
xlabel('time (s)')
ylabel('xc (mm)')
grid on
hold all
xlim([0 tend])
subplot(2,2,2)
plot(t,xcdot)
xlabel('time (s)')
ylabel('xcdot (mm/s)')
grid on
hold all
xlim([0 tend])
subplot(2,2,3)
plot(t,alpha)
xlabel('time (s)')
ylabel('alpha (deg)')
grid on
hold all
xlim([0 tend])
subplot(2,2,4)
plot(t,alphadot)
xlabel('time (s)')
ylabel('alphadot (deg/s)')
grid on
hold all
xlim([0 tend])

%% SIM PLACE method
[alphadot_start,Istart] = min(alphadot(1:1000));
alphadot_start = alphadot(Istart);
alpha_start = alpha(Istart);
xcdot_start = xcdot(Istart);
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = alpha_start*0.0174532925; %rads
IC_ALPHAdot0 = alphadot_start*0.0174532925; %rads/s
xcdot_0 = xcdot_start; %mm/s
P1 = -1;
P2 = -5;
P3 = -8;
P4 = -10;
poles = [P1, P2, P3, P4]
K = place(A,B, poles)
sim('s_sip_lqr')
t = xc_out.Time + 0.104;
xc = xc_out.Data;
xcdot = xcdot_out.Data;
alpha = alpha_out.Data;
alphadot = alphadot_out.Data;
    alphadot(1) = alphadot(2);

figure(2)
subplot(2,2,1)
plot(t,xc)
legend('EXP - PLACE method','SIM - PLACE method')
hold all
subplot(2,2,2)
plot(t,xcdot)
legend('EXP - PLACE method','SIM - PLACE method')
hold all
subplot(2,2,3)
plot(t,alpha)
legend('EXP - PLACE method','SIM - PLACE method')
hold all
xlim([0 tend])
subplot(2,2,4)
plot(t,alphadot)
legend('EXP - PLACE method','SIM - PLACE method')
hold all








