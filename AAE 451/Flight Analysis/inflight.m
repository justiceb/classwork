clc; clear; close all;
load('2014-12-02 10-58-22.log-48692.mat');

lat = GPS(:,7);
long = GPS(:,8);
gps_alt = GPS(:,10);
gps_time = GPS(:,3);

%format 3d trajectory
trajectory = [gps_alt,long,lat];