% Step3_Simulink_SimMATLAB5     Version 8.0 1/23/03
% 
% OBJECTIVE: Simulate an aircraft in 6 degree of freedom motion
%            with nonlinear equations of motion and nonlinear
%            aerodynamic and thrust models. A flat earth and
%            rigid body dynamics are assumed.
% INPUT: In the Matlab workspace will be defined initial conditions
%        on the state and controls (xIC and uIC). The array constant, xIC and uIC
%        are all required by this SIMULINK nonlinear simulation.
% OUTPUT: Arrays in the MATLAB workspace called taircraft and yaircraft 
%         that contain an aray of time values and a matrix of output state 
%         time histories.
echo on
%
% MATLAB 5 users will run
% the nonlinear simulation in SIMULINK using FlatEarth_MATLAB5.mdl.
%
% To bring up Simulink, type simulink from the Matlab command window.
%
% From the Simulink window, use the File Open menu
%   to open the Simulink model  FlatEarth_MATLAB5.mdl.
%
% To run the Simulink simulation click on the run button (>).
%
% Alternately, you can execute the following command and the 
% SIMULINK nonlinear simulation will run using default times and options.
%
% sim('FlatEarth_MATLAB5')
echo off
