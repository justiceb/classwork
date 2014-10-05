clc; clear; close all;

run ('setup_lab_ip01_2_sip')
CART_TYPE = 'IP02';
IP02_LOAD_TYPE = 'WEIGHT';
PEND_TYPE = 'LONG_24IN';
IC_ALPHA0 = 0.2;

P1 = -1;
P2 = -2;
P3 = -3;
P4 = -4;
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

R = 0.1;
q1 = 10;
q2 = 10;
q3 = 1;
q4 = 1;
K = lqr(A,B, diag([q1, q2, q3, q4]),R)
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

%{
% Our new system will be,
Alqr = A-B*K;
Blqr = B;
Clqr = C;
Dlqr = D;
[numlqr, denlqr] = ss2tf(Alqr,Blqr,Clqr,Dlqr)
syslqr = tf(numlqr,denlqr)
%}

