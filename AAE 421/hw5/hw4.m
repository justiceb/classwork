close all; clear; clc;

%% Problem 2C
syms x1 x2
x1dot = 2*x2*(1-x1) - x1;
x2dot = 3*x1*(1-x2) - x2;

%solve equilibrium values
sol = solve(x1dot == 0, x2dot == 0);
x1e = (sol.x1)
x2e = (sol.x2)

%linearize
A = [diff(x1dot,x1),    diff(x1dot,x2);...
     diff(x2dot,x1),    diff(x2dot,x2)]
 
%substitute 
subs(A,{x1,x2},{double(x1e(2)),double(x2e(2))})
subs(A,{x1,x2},{double(x1e(1)),double(x2e(1))})

%% Problem 3
syms x1 x2
x1dot = 1-exp(x1-x2);
x2dot = x1;
sol = solve(x1dot == 0, x2dot == 0);
x1e = (sol.x1);
x2e = (sol.x2);

A = [diff(x1dot,x1),    diff(x1dot,x2);...
     diff(x2dot,x1),    diff(x2dot,x2)]
 
%% Problem 4 - analytical solution
syms x1 x2 L k w m g
x1dot = x2;
x2dot = (-1/(m*L))*(k*(L*x2-w*sin(x1))*sqrt(L^2*x2^2+w^2-2*L*w*sin(x1)*x2)+m*g*sin(x1));
sol = solve(x1dot == 0, x2dot == 0);

%solve equilibrium values
x1e = (sol.x1)
x2e = (sol.x2)

%linearize
A = [diff(x1dot,x1),    diff(x1dot,x2);...
     diff(x2dot,x1),    diff(x2dot,x2)]
 
 %substitute 
subs(A,{x1,x2},{0,0})
subs(A,{x1,x2},{pi,0})

