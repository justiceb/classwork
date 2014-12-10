% Step2_Trim.m    Version 8.0 1/23/03
%
% OBJECTIVE: Trim the aircraft and develop initial conditions for the
%            SIMULINK nonlinear simulation.
%
% INPUTS: the array called constant
% OUTPUTS: In the Matlab workspace will be defined initial conditions
% on the state and controls (xIC and uIC). The array constant, xIC and uIC
% are all required by the SIMULINK nonlinear simulation.
%
%

% Quick trim the Predator
disp(' '); disp(' ')
disp(' >>>>>>>>>>>Start here, Step2_Trim <<<<<<<<<<<<<<<')
disp(' ')

disp(aircraft); % Display aircraft identification
% Establish a trim condition (initial condition).
Vt=constant(58); % Trim airspeed (ft/sec)
Hp=constant(59); % Trim altitude (ft)
% Alternately you can make changes to the trim airspeed and 
% altitude here if the nondimensional stability and control
% derivatives in the array called constant are not strongly
% dependent on trim airspeed ar alitude, as is often the case.

% At this point in the script if you want you can change the c.g. location as follows.
% constant(57)=.25;  		
% XbarCG,  nondimensional, measured aft from leading edge of wing mean aerodynamic chord.

s1=['Trim airspeed=',num2str(Vt),' ft/sec, '];
s2=['Trim altitude=',num2str(Hp),' ft, '];
s3=['c.g.=',num2str(constant(57)),' cbar.'];
disp(' '); disp([s1 s2 s3]); disp(' ');

% Define the steady winds
disp('NED omponents of the steady wind')
VwindKnots=0;
Vwx=-VwindKnots*1.687808 %ft/sec, - sign means headwind
Vwy=0
Vwz=0 

% Trim the aircraft
disp('Trim conditions')
echo on
% States x
%   x=[U,V,W,P,Q,R,Phi,Theta,Psi,Xprime,Yprime,Hprime]
%   Units are [ft/sec, ft/sec, ft/sec, rad/sec, rad/sec, rad/sec, rad, rad, rad, ft, ft, ft]
% Inputs u
%   u=[deltaE,deltaA,deltaR,bhp, Vwx, Vwy, Vwz]]
%   Units are [rad,rad,rad,bhp, ft/sec, ft/sec, ft/sec]
echo off
[xIC,uIC,CL,CD,CM,alphadeg]=QuickTrim2(Vt,Hp,constant,Vwx,Vwy,Vwz)

% Check to insure that the derivatives of the state vector (sys) are small 
% for this trim condition.
flag=1;;t=0;
[Xdot] = aircraft7(t,xIC,uIC,flag,constant,xIC);
disp('Trim Check: The first 9 derivatives (Xdot) should be small at trim')
Xdot
disp('  Now you are ready to run the nonlinear simulation using')
disp('  SIMULINK with the model called FlatEarth_MATLAB6.mdl from MATLAB 6')
disp('                              or FlatEarth_MATLAB5.mdl from MATLAB 5.')

