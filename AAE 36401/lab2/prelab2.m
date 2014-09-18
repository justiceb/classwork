clc; clear; close all;

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

%% Pre-lab Part 2.1
%Part 2(i) : Hand in your values for the damping ratio  and natural frequency !n that you calculated.
denom = [1 11.74 26.96 263.4];
r = roots(denom)
poly1 = poly(r(2:3))
wn = sqrt(poly1(3))
damping = poly1(2)/(2*wn)

%bode plot
H = tf([-3.526 0],[1 11.74 26.96 263.4]);
bode(H)
[MAG, PHASE] = bode(H,3)
[MAG, PHASE] = bode(H,7)

%% Pre-lab Part 3.1







































