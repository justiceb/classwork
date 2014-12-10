clc; clear; close all

%load altimeter data
data1 = import_eagle_data('altimeter1.FDR',10,inf);
t1 = data1.col1;   %ms from bootup
alt1 = data1.col5; %feet

data2 = import_eagle_data('altimeter2.FDR',10,inf);
t2 = data2.col1;   %ms from bootup
alt2 = data2.col5; %feet

data3 = import_eagle_data('altimeter3.FDR',10,inf);
t3 = data3.col1;   %ms from bootup
alt3 = data3.col5; %feet

figure(1)
subplot(3,1,1)
plot(t1*0.001,alt1)
title('Comparison of 3 altimeter datasets for down and up a flight of stairs')
xlabel('time (s)')
ylabel('altitude (feet)')
ylim([-20,5])
grid on
subplot(3,1,2)
plot(t2*0.001,alt2)
xlabel('time (s)')
ylabel('altitude (feet)')
ylim([-20,5])
grid on
subplot(3,1,3)
plot(t3*0.001,alt3)
xlabel('time (s)')
ylabel('altitude (feet)')
ylim([-20,5])
grid on

%load GPS data
clear
data1 = import_eagle_data('GPS_hill2.FDR',10,inf);
t1 = data1.col1 + 13750;   %ms from bootup
alt1 = data1.col5 + 13; %feet
gps_lat1 = data1.col19;
gps_long1 = data1.col20;
gps_alt1 = data1.col21;
    gps_alt1 = gps_alt1 - gps_alt1(1);
numsats1 = data1.col26;

data2 = import_eagle_data('GPS_hill1.FDR',10,inf);
t2 = data2.col1;   %ms from bootup
alt2 = data2.col5 + 13; %feet

figure(2)
plot(gps_lat1,gps_long1)

figure(3)
subplot(2,1,1)
plot(t1*1.66667e-5,gps_alt1,t1*1.66667e-5,alt1,t2*1.66667e-5,alt2)
xlabel('time (minutes)')
ylabel('altitude (ft)')
grid on
legend('GPS altitude','altimeter altitude #1','altimeter altitude #2')
subplot(2,1,2)
plot(t1*1.66667e-5,numsats1)
xlabel('time (minutes)')
ylabel('number of visible GPS sats')
grid on

trajectory = [data1.col21,gps_lat1,gps_long1];




