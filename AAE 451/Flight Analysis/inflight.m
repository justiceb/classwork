clc; clear; close all;
addpath('dataflash')
addpath('radio_telemetry')
flash = load('2014-12-02 10-58-22.log-48692.mat');
radio = load('2014-12-02 10-53-15.tlog.mat');

%% Plot Pressure
figure(1)
flash.ptime = (flash.BARO(:,2)- flash.BARO(1,2))*0.001; %s
flash.p = flash.BARO(:,4);
plot(flash.ptime,flash.p)
hold all
radio.p = radio.press_abs_mavlink_scaled_pressure_t(:,2) * 100; %Pascals
radio.time = (radio.time_boot_ms_mavlink_scaled_pressure_t(:,2) - radio.time_boot_ms_mavlink_scaled_pressure_t(1,2)) *0.001;
plot(radio.time,radio.p)
xlabel('time (s)');
ylabel('Baro Pressure (Pa)')
grid on
legend('dataflash','radio',0)

%% Pressure altitude
Hchart = 0:0.01:10;                    %km
Pchart = atmo_p(Hchart);               %Pa
radio.p_alt = interp1(Pchart,Hchart,radio.p)*1000;  %m
radio.p_alt = radio.p_alt - radio.p_alt(end);
flash.p_alt = interp1(Pchart,Hchart,flash.p)*1000;  %m
flash.p_alt = flash.p_alt - flash.p_alt(end);

figure(2)
plot(flash.ptime,flash.p_alt*3.28084,'.')
hold all
flash.GPS = flash.GPS(3:end,:);
flash.GPStime = (flash.GPS(:,3)-flash.GPS(1,3))*0.001; %s
flash.GPSalt = flash.GPS(:,10) - 149.8;
plot(flash.GPStime,flash.GPSalt*3.28084,'.')
%hold all
%plot(radio.time,radio.p_alt*3.28084)
hold all
plot((248.4)*[1 1],get(gca,'ylim'),'k');
hold all
plot((256)*[1 1],get(gca,'ylim'),'k');
xlabel('time (s)')
ylabel('altitude AGL (ft)')
grid on
legend('dataflash pressure alt','dataflash GPS alt',0)

%% Vertical Velocity
flash.pvz(1) = 0;                                                 %(m/s)
for n = 2:1:length(flash.ptime)
   dt = flash.ptime(n) - flash.ptime(n-1);
   flash.pvz(n) = (flash.p_alt(n) - flash.p_alt(n-1) )/dt;   %(m/s)
end

flash.GPSvz(1) = 0;                                                 %(m/s)
for n = 2:1:length(flash.GPStime)
   dt = flash.GPStime(n) - flash.GPStime(n-1);
   flash.GPSvz(n) = (flash.GPSalt(n) - flash.GPSalt(n-1) )/dt;   %(m/s)
end

figure(3)
plot(flash.ptime,flash.pvz*3.28084,'.b')
hold all
plot(flash.GPStime,flash.GPSvz*3.28084,'.r')
hold all
%windowSize = 5;
%b = (1/windowSize)*ones(1,windowSize);
%a = 1;
%flash.pvz_filter = filter(b,a,flash.pvz);
%flash.GPSvz_filter = filter(b,a,flash.GPSvz);
[~,flash.pvz_filter] = movavg(flash.pvz,1,10,0);
[~,flash.GPSvz_filter] = movavg(flash.GPSvz,1,10,0);
plot(flash.ptime,flash.pvz_filter*3.28084,'b')
hold all
plot(flash.GPStime,flash.GPSvz_filter*3.28084,'r')
hold all
plot((248.4)*[1 1],get(gca,'ylim'),'k');
hold all
plot((256)*[1 1],get(gca,'ylim'),'k');
xlabel('time (s)')
ylabel('Vertical Speed (ft/s)')
legend('dataflash pressure alt','dataflash GPS alt','dataflash pressure alt (filtered)','dataflash GPS alt (filtered)','parachute deployment','ground impact',0)

figure(4)
m = 3.50173; %kg
plot(flash.ptime,flash.pvz.^2*0.737562149/2*m,'.b')
hold all
plot(flash.GPStime,flash.GPSvz.^2*0.737562149/2*m,'.r')
hold all
plot(flash.ptime,flash.pvz_filter.^2*0.737562149/2*m,'b')
hold all
plot(flash.GPStime,flash.GPSvz_filter.^2*0.737562149/2*m,'r')
hold all
plot((248.4)*[1 1],get(gca,'ylim'),'k');
hold all
plot((256)*[1 1],get(gca,'ylim'),'k');
xlabel('time (s)')
ylabel('Kinetic energy (ft-lbs)')
legend('dataflash pressure alt','dataflash GPS alt','dataflash pressure alt (filtered)','dataflash GPS alt (filtered)','parachute deployment','ground impact',0)

%% Accelerometers
figure(5)
flash.IMUtime = (flash.IMU(:,2) - flash.IMU(1,2)) * 0.001;
plot(flash.IMUtime,flash.IMU(:,6)/9.81)
hold all
plot(flash.IMUtime,flash.IMU(:,7)/9.81)
hold all
plot(flash.IMUtime,flash.IMU(:,8)/9.81)
grid on 
legend('x','y','z',0)

%% GPS sats
figure(6)
plot(flash.GPStime,flash.GPS(:,5))
xlabel('time (s)')
ylabel('Nsats')
grid on

%% 3D plot
lat = flash.GPS(:,7);
long = flash.GPS(:,8);
gps_alt = flash.GPS(:,10);
trajectory_flash = [gps_alt,long,lat];

lat = radio.lat_mavlink_gps_raw_int_t(:,2)*1E-7;
long = radio.lon_mavlink_gps_raw_int_t(:,2)*1E-7;
gps_alt = radio.alt_mavlink_gps_raw_int_t(:,2)*1E-3;
trajectory_radio = [gps_alt,long,lat];

trajector_spliced = [trajectory_radio(1:491,:);trajectory_flash];

%figure(7)
%time = radio.time_usec_mavlink_gps_raw_int_t(:,2) - radio.time_usec_mavlink_gps_raw_int_t(1,2);
%plot(time/1000000,gps_alt)
%492
