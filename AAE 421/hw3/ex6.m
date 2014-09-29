clc; clear; close all;

%given
g = 0.81;
m = 0.1;
K = 1;
k = 0.001;
w = 10;

%equilibrium value of q
q_equib = (m*g-w^2*k)/K

%run sim
%initial conditions
q_dot_0   = 0;
q_0       = 0;
sim('ex6_model')