clc; clear; 

%% inputs
long0 = -106.750880;
lat0 = 33.221587;
alt0 = 200 * 0.3048; %m initial altitude
alt_end = 0;         %ground level
wind = load_Wyoming_Sounding('no_wind.csv');
mass = 6.25 * 0.453592; %kg
windx = 45 * 0.3048; %m/s
vx0 = 30.25 * 0.3048 + windx; %m/s initial horizontal velocity
vy0 = 0;

%determine parachute drag criteria
CD = 1.5;                       %domed parachute, source: http://my.execpc.com/~culp/rockets/descent.html
Dparachute = 36 * 0.0254;       %m parachute diameter
Aref = pi * (Dparachute/2)^2;   %m^2 parachute area

%{
for n = 1:1:length(Aref)
%% Run ODE45 solver
[ long, lat, sz, data ] = descent_trajectory( long0, lat0, alt0, alt_end, wind, CD, Aref(n), mass, vx0, vy0, windx );
sx = data.sx;
sy = data.sy;
vx = data.vx;
vy = data.vy;
vz = data.vz;
t = data.t;

%% analyze
figure(1)
subplot(221)
plot(t,sz*3.28084)
xlabel('time (s)')
ylabel('altitude (feet)')
grid on
hold all
legend('30"','36"','48"','60"','78"',0)
subplot(222)
plot(t,vz*3.28084)
xlabel('time (s)')
ylabel('vertical velocity (ft/s)')
grid on
hold all
legend('30"','36"','48"','60"','78"',0)
subplot(223)
plot(sx*3.28084,sz*3.28084)
xlabel('downrange distance (feet)')
ylabel('altitude (feet)')
grid on
hold all
legend('30"','36"','48"','60"','78"',0)
axis equal
subplot(224)
plot(t,0.5*mass*vz.^2*0.737562149)
xlabel('time (s)')
ylabel('kinetic energy (ft-lbs)')
grid on
hold all
legend('30"','36"','48"','60"','78"',0)

end
%}

[ long, lat, sz, data ] = descent_trajectory( long0, lat0, alt0, alt_end, wind, CD, Aref, mass, vx0, vy0, windx );
sx = data.sx;
sy = data.sy;
vx = data.vx;
vy = data.vy;
vz = data.vz;
t = data.t;

figure(2)
subplot(221)
plot(t,sz*3.28084)
xlabel('time (s)')
ylabel('altitude (feet)')
grid on
hold all
legend('wind = 15 ft/s','wind = 25 ft/s','wind = 35 ft/s','wind = 45 ft/s',0)
subplot(122)
plot(sx*3.28084,sz*3.28084)
xlabel('downrange distance (feet)')
ylabel('altitude (feet)')
grid on
hold all
legend('wind = 15 ft/s','wind = 25 ft/s','wind = 35 ft/s','wind = 45 ft/s',0)
axis equal
subplot(223)
plot(t,vx*3.28084)
xlabel('time (s)')
ylabel('lateral speed (feet/s)')
grid on
hold all
legend('wind = 15 ft/s','wind = 25 ft/s','wind = 35 ft/s','wind = 45 ft/s',0)
