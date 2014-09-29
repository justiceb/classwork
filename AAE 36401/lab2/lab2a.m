clc; clear; close all;
addpath data

%% Given constants
Rm =	2.6; %motor armature resistance (ohms)
Lm = 	0.18; %motor armature inductance (mH)
Kt =	0.00767; %motor torque constant (N-m/A)
nu_m =	1; %motor efficiency ()
Km =	0.00767; %back-electromotive-force(EMF) constant (V-s/rad)
Jm =	3.90E-07; %rotor moment of inertia (kg-m^2)
Kg =	3.71; %planetary gearbox ratio ()
nu_g =	1; %planetary gearbox efficiency ()
Mc2 =	0.57; %cart mass (kg)
Mw =	0.37; %cart weight mass (kg)
Mc =	1.0731; %total cart weight mass including motor inertia (kg)
Beq =	5.4; %viscous damping at motor pinion (N-s/m)
Lt =	0.99; %track length (m)
Tc =	0.814; %cart travel (m)
Pr =	1.664E-3; %rack pitch (m/tooth)
rmp =	6.35E-3; %motor pinion radius (m)
Nmp =	24; %motor pinion number of teeth ()
rpp =	0.01482975; %position pinion radius (m)
Npp =	56; %position pinion number of teeth ()
KEP =	2.275E-5; %cart encoder resolution (m/count)
Mp =	0.23; %long pendulum mass with T-fitting (kg)
Mpm =	0.127; %medium pendulum mass with T-fitting (kg)
Lp =	0.6413; %long pendulum length from pivot to tip (m)
Lpm =	0.3365; %medium pendulum length from pivot to tip (m)
lp =	0.3302; %long pendulum length: pivot to center of mass (m)
lpm =	0.1778; %medium pendulum length: pivot to center of mass (m)
Jp =	7.88E-3; %long pendulum moment of inertia  center of mass (kg-m^2)
Jpm =	1.2E-3; %medium pendulum moment of inertia  center of mass (kg-m^2)
Bp =	0.0024; %viscous damping at pendulum axis (N-m-s/rad)
g =	    9.81; %gravitational constant (m/s^2)

%% Part 1
load part_1_theta
t = theta.time;
t = t-t(1);
theta = theta.signals.values;
figure(1)
plot(t,theta)
xlabel('time (s)')
ylabel('angle (degrees)')
grid on

%find period of osciallation
[~,ipeak]=findpeaks(theta);
for n = 1:1:(length(ipeak)-1)
    period(n) = t(ipeak(n+1)) - t(ipeak(n));
end
period = mean(period) %s

%find natural frequency
wp = 2*pi/period %rad/s

%% Part 2
%Part a: Hand in your values for the damping ratio  and natural frequency !n that you calculated.
denom = [1 11.74 26.96 263.4];
r = roots(denom);
poly1 = poly(r(2:3))
wn = sqrt(poly1(3))
damping = poly1(2)/(2*wn)

%part c - bode plot
H = tf([-3.526 0],[1 11.74 26.96 263.4]);
figure(2)
bode(H)

%part d - plot experimental data
load part_2_w3_theta
t3 = theta.time - theta.time(1);
theta3 = theta.signals.values;
amp3 = (max(theta3)-min(theta3))/2;
load part_2_wn_theta
tn = theta.time - theta.time(1);
thetan = theta.signals.values;
ampn = (-min(thetan))/1;
load part_2_w7_theta
t7 = theta.time - theta.time(1);
theta7 = theta.signals.values;
amp7 = (max(theta7)-min(theta7))/2;

figure(3)
plot(t3,theta3,tn,thetan,t7,theta7)
xlabel('time (s)')
ylabel('angle (radians)')
grid on
legend('w = 3 rad/s','w = wn = 4.8 rad/s','w = 7 rad/s',0)

%part e - find magnitude of xfer function at various w
A = 3;  %voltage sinusoidal amplitude input
MAG3_calc = amp3/A
MAGn_calc = ampn/A
MAG7_calc = amp7/A
MAG3db_calc = mag2db(MAG3_calc);
MAGndb_calc = mag2db(MAGn_calc);
MAG7db_calc = mag2db(MAG7_calc);

[MAG3, ~] = bode(H,3)
[MAGn, ~] = bode(H,wn)
[MAG7, ~] = bode(H,7)
MAG3db = mag2db(MAG3);
MAGndb = mag2db(MAGn);
MAG7db = mag2db(MAG7);






















