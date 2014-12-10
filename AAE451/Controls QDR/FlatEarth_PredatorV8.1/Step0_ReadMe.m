% Step0_ReadMe.m    Version 8.1 1/23/03
%
echo on
disp(' ')
% These MALAB scripts are designed to analyze and simulate arbitrary 
% rigid aircraft over the flat earth. A vehicle description file 
% called Basic_Constants_Predator is included allowing analysis 
% of the Predator UAV.
%  
% It is important that these MATLAB scripts be run in order.
% 
% Step1_Predator_Model.m
% Step2_Trim.m
% Step3_Simulink_SimMATLAB5.m or Step3_Simulink_SimMATLAB6.m
% Step4_Plot_Noninear_Sim.m  (optional step)
% Step5_Linearize_MATLAB5.m or Step5_Linearize_MATLAB6.m
% Step6_Longitudinal_Design.m
% Step7_Lateral_Design.m (can be run after Step5)
%
% MATLAB 5 and 6 versions of several files are provided allowing users
% of either version of MATLAB to use the software.
%
echo off
