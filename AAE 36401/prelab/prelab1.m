clc; clear; close all;

%% Given
Rm = 2.6;         %motor armature resistance 2.6 ?
Lm = 0.18;        %motor armature inductance 0.18 mH
Kt = 0.00767;     %motor torque constant 0.00767 N.m/A
nu_m = 1.00;      %motor e?ciency 100% %
Km = 0.00767;     %back-electromotive-force(EMF) 0.00767 V.s/rad
Jm = 3.9E-7;      %rotor moment of inertia 3.9 × 10?7 kg.m2
Kg = 3.71;        %planetary gearbox ratio 3.71
nu_g = 1.00;      %planetary gearbox e?ciency 100% %
Mc = 0.57;        %cart mass 0.57 kg
Mw = 0.37;        %cart weight mass 0.37 kg
Lt = 0.990;       %track length 0.990 m
Tc = 0.814;       %cart travel 0.814 m
Pr = 1.664E-3;    %rack pitch 1.664 × 10?3 m/tooth
rmp = 6.35E-3;    %motor pinion radius 6.35 × 10?3 m
Nmp = 24;         %motor pinion number of teeth 24
rpp = 0.01482975; %position pinion radius 0.01482975 m
Npp = 56;         %position pinion number of teeth 56
KEP = 2.275E-5;   %cart encoder resolution 2.275 × 10?5 m/count

%% Part (i)
%find gamma, m, Bemf
M = Mc + Mw;                   %kg total cart system mass
Mj = (nu_g*Kg^2*Jm)/(rmp^2);   %effective mass added to the system due to the moment of inertia of the motor
m = M + Mj                     %

Bemf = (nu_g*Kg^2*nu_m*Kt*Km)/(Rm*rmp^2)
gamma = (nu_g*Kg*nu_m*Kt)/(Rm*rmp)

%% Part (ii)
%determine largest ki for stable root locus given parameters
k = 10;    %V/m
Beq = 5.4; %kg/s
c = Beq + Bemf;

num = [gamma];
denom = [m, c, gamma*k, 0];
rlocus(num,denom) 

ki_max = 86.5;
poly_rooms = roots([m c gamma*k gamma*ki_max])

%% Part (iii)
kp = 1000;
ki = 20;
kd = 100;















