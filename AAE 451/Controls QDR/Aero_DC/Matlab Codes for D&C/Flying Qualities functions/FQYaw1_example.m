clear; clc; close all
Basic_Constants_MPX5;
Make_Constants;

%% User Inputs
max_dr_deg=20; %maximum rudder deflection degrees
class=1; %Airplane Class
gamma=0;     % flight path angle degrees
flag=1; %Plot flag
%% Calculations
max_dr=deg2rad(max_dr_deg);
FyT1=0;LT1=0;NT1=0;DND1=0;
FQYaw1_doc;
disp(' ')
disp(' ')
disp('Outputs')
[level d_dr_req]=FQYaw1(W,rho,U1,S_w,b_w,constant(34),constant(35),constant(36),...
    constant(40),constant(41),constant(42),constant(51),constant(52),...
    constant(53),gamma,FyT1,LT1,NT1,DND1,max_dr,flag,class)
