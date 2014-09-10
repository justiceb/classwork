clc; clear; close all;
addpath('Data');

%% Given Constants
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

%Load collected data
load('Justice_1_y')
t = y.time;
t = t-t(1);
y = y.signals.values;
figure(1), plot(t,y)
xlabel('time (s)')
ylabel('Position (m)')
grid on
hold all

%estiamte Beq
ydot_0 = 0.3621;  %observed from graph
syms Beq
Beq = double(solve(y(end) == ydot_0*m/Beq))
c = Beq + Bemf

%Plot esitamted curve with Beq
y_estim = (ydot_0*m/Beq)*(1 - exp(-Beq*t/m));
plot(t+0.944,y_estim)
legend('Measured','Estimated',0)

%% Part (ii)
for n = 1:1:2
    if n == 2
        Beq = 2.5;
        c = Beq + Bemf;
    end
    
    %Load collected data
    load('Justice_2_y')
    load('Justice_2_v')
    t = y.time;
    y = y.signals.values;
    v = v.signals.values;
    figure(n+1)
    subplot(2,1,1), plot(t,y)
    title(sprintf('Beq = %f',Beq))
    xlabel('time (s)')
    ylabel('Position (m)')
    grid on
    hold all
    subplot(2,1,2), plot(t,v)
    xlabel('time (s)')
    ylabel('Voltage Input (volts)')
    grid on
    hold all

    %Sim 2a
    k = 50; %V/m
    r0 = 0.4;  %m
    t_end = t(end);
    sim('part2a')
    subplot(2,1,1), plot(y_sim.Time,y_sim.Data)
    hold all
    subplot(2,1,2), plot(v_sim.Time,v_sim.Data)
    hold all

    %Sim 2b
    k = 50; %V/m
    r0 = 0.4;  %m
    t_end = t(end);
    sim('part2b')
    subplot(2,1,1), plot(y_sim.Time,y_sim.Data)
    legend('Actual','Sim - no saturation','Sim - saturation',0)
    subplot(2,1,2), plot(v_sim.Time,v_sim.Data)
    legend('Actual','Sim - no saturation','Sim - saturation',0)
end

%% Part (iii)a
%Load collected data
load('justice_3_y')
load('justice_3_v')
t = y.time;
y = y.signals.values;
v = v.signals.values;
figure(4)
subplot(2,1,1), plot(t,y)
xlabel('time (s)')
ylabel('Position (m)')
grid on
hold all
subplot(2,1,2), plot(t,v)
xlabel('time (s)')
ylabel('Voltage Input (volts)')
grid on
hold all

%determine when cart starts moving
n = 0;
flag = 0;
while flag == 0
    n = n+1;
    if y(n)>0
       t0 = t(n); 
       v_t0 = v(n);
       flag = 1;
    end
end
subplot(2,1,2), plot(t0,v_t0,'o')
legend('ramp input','cart starts moving',0)
fc = gamma*v_t0


%% Part (iii)b
load('justice_3_e')
t = e.time;
e = e.signals.values;
figure(5)
plot(t,e)
xlabel('time (s)')
ylabel('error')
grid on
hold all

%Sim
k = 10; %V/m
r0 = 0.4;  %m
t_end = t(end);
sim('part3')
plot(e_sim.Time,e_sim.Data)
legend('Actual','Sim',0)

%e_inf
e_inf_max = fc/(k*gamma)
e_inf = e(end)
e_inf_sim = e_sim.Data(end)

%% Part (iv)
load('justice_4_e')
t = e.time;
e = e.signals.values;
figure(6)
plot(t,e)
xlabel('time (s)')
ylabel('error')
grid on
hold all

%sim
kp = 10;
ki = 15;
kd = 0;
t_end = t(end);
sim('part4')
plot(e_sim.Time,e_sim.Data)
legend('Actual','Sim',0)

%determine largest ki for stable root locus given parameters
k = 10;    %V/m

num = [gamma];
denom = [m, c, gamma*k, 0];
figure(7)
rlocus(num,denom) 

ki_max = 51.6;  %observed from root locus plot
poly_rooms = roots([m c gamma*k gamma*ki_max])

%% Part (v)a
load('justice_5_y')
load('justice_5_v')
load('justice_5_e')
t = y.time;
y = y.signals.values;
v = v.signals.values;
e = e.signals.values;
figure(8)
subplot(3,1,1), plot(t,y)
xlabel('time (s)')
ylabel('Position (m)')
grid on
hold all
subplot(3,1,2), plot(t,v)
xlabel('time (s)')
ylabel('Voltage Input (volts)')
grid on
hold all
subplot(3,1,3), plot(t,e)
xlabel('time (s)')
ylabel('error')
grid on
hold all

%sim
kp = 1000;
ki = 20;
kd = 5;
t_end = t(end);
sim('part5')
subplot(3,1,1), plot(y_sim.Time,y_sim.Data)
legend('Actual','Sim',0)
subplot(3,1,2), plot(v_sim.Time,v_sim.Data)
legend('Actual','Sim',0)
subplot(3,1,3), plot(e_sim.Time,e_sim.Data)
legend('Actual','Sim',0)

%% Part (v)b
load('justice_5b_y')
load('justice_5b_v')
load('justice_5b_e')
t = y.time;
y = y.signals.values;
v = v.signals.values;
e = e.signals.values;
figure(9)
subplot(3,1,1), plot(t,y)
xlabel('time (s)')
ylabel('Position (m)')
grid on
hold all
subplot(3,1,2), plot(t,v)
xlabel('time (s)')
ylabel('Voltage Input (volts)')
grid on
hold all
subplot(3,1,3), plot(t,e)
xlabel('time (s)')
ylabel('error')
grid on
hold all

%sim
kp = 400;
ki = 5;
kd = 20;
t_end = t(end);
sim('part5')
subplot(3,1,1), plot(y_sim.Time,y_sim.Data)
legend('Actual','Sim',0)
subplot(3,1,2), plot(v_sim.Time,v_sim.Data)
legend('Actual','Sim',0)
subplot(3,1,3), plot(e_sim.Time,e_sim.Data)
legend('Actual','Sim',0)



























