%FQPitch2 Doc
disp(' ')
disp(' ')
disp('<<<<<<<<<<<Executing FQPitch2 - Longitudinal Control Margin MIL-STD-1797A Sec 4.1.11.5')
disp(' ')
disp(' ')
echo on
%[q_sim t_sim1 alpha_sim t_sim2 level]=FQPitch2(de,Lsys,y1,sim_run_time)
%Calculate the pitch rate after 2 seconds from a step input to elevator of
%maximum elevator deflection.
% References
% [1] Roskam, Jan. "Airplane Flight Dynamics and Automatic Flight Controls", 
%     DARcorporation Lawrence, KS Second Printing, 1998.
% 
% [2] Roskam, Jan. “Airplane Design: Part VII Determination of Stability, 
%                  Control, and Performance Characteristics: 
%                  FAR and Military Requirements. DARcorporation. Lawrence, KS, 2002.
% 
% [3] Raymer, Daniel P. “Aircraft Design: A Conceptual Approach” AIAA 
%                       Education Series. Reston, VA Fourth Edition, 2006.
% 
% [4] Anon.; MIL-F-8785c, Military Specification Flying Qualities of 
%            Piloted Airplanes; November 5, 1980; Air Force Flight 
%            Dynamics Laboratory, WPAFB, Dayton, OH.
% 
% [5] Anon.; MIL-STD-1797A, Flying Qualities of Piloted Aircraft; 
%            January 30, 1990; Air Force Flight Dynamics 
%            Laboratory, WPAFB, Dayton, OH.
%Input Variables:
%de - elevator deflection angle (rad)
%Lsys - Longitudinal Directional Linear System
%
%Output Variables:
%q_sim - Pitch rate from step input to elevator
%t_sim1 - time from pitch rate response to step input to elevator
%alpha_sim - alpha from step input to elevator
%t_sim2 - time from alpha response to step input to elevator
%level - Flying quality level
echo off
format compact
disp('Function Inputs')
de
Lsys
y1
sim_run_time

disp('User Inputs')
CL_max
sim_run_time
de_deg

format loose