clc; clear; close all

%aircraft properties
W = 2650*4.44822162; %newtons
g = 9.81; %m/s/s
m = W/g; %kg
S = 174*0.092903; %m^2
c = 4.9*0.3048; %m
J2 = 1346*1.35581795; %kg*m^2
el = 0; %rads
rho = 1.225; %kg/m^3

%lift constants
CL0 = 0.307;
CLalpha = 4.41;  %/rad
CLel = 0.43; %/rad
CLalpha_dot = 1.7; %/rad
CLq = 3.9; %/rad

%drag constants
CDM = 0.0223;
k = 0.0554;
CLDM = 0;

%moment constants
CM0_R = 0.04;
CMalpha_R = -0.613; %/rad
CMel_R = -1.122; %/rad
CMalpha_dot_R = -7.27; %/rad
CMq_R = -12.4; %/rad
xcm = 0;

%thrust constants
nu = 0.7;  %prop efficiency
%th = 100*745.699872; %watts
th = 0; %hp
e = 0;
eT = 0;

%initial conditions
V0 = 45;
theta0 = 0;
q0 = 0;
alpha0 = 0;
p0 = 0;
h0 = 1000;

sim('cessna_model')
t = simout.Time;
p = simout.Data(:,1);
h = simout.Data(:,2);
V = simout.Data(:,3);
alpha = simout.Data(:,4);
gamma = simout.Data(:,5);

figure(1)
subplot(2,2,1)
plot(t,V)
xlabel('time (s)')
ylabel('Speed [mag(V)] (m/s)')
grid on
subplot(2,2,2)
plot(t,alpha*57.2957795)
xlabel('time (s)')
ylabel('angle of attack [alpha] (deg)')
grid on
subplot(2,2,3)
plot(t,gamma*57.2957795)
xlabel('time (s)')
ylabel('gamma (deg)')
grid on
subplot(2,2,4)
plot(t,h)
xlabel('time (s)')
ylabel('altitude [h] (m)')
grid on
figure(2)
plot(p,h)
xlabel('downrange distance [p] (m)')
ylabel('altitude [h] (m)')
grid on






