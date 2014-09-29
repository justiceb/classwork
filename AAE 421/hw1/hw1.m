clc; clear, close all;

%given
m = 1;
K = 49;
C = 2;
k = 1;
c = 0.5;

%initial conditions
q1_dot_0   = 0;
q1_0       = 0;
q2_dot_0   = 0;
q2_0       = 1;

sim('hw1_model')

