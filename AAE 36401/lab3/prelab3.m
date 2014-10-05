clc; clear; close all;

run ('setup_lab_ip01_2_sip')
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = 0;
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
axis([0 20 -0.25 0.25])
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
