%FQPitch1 Doc
disp(' ')
disp(' ')
disp('<<<<<<<<<<<Executing FQPitch1 - Longitudinal Control in Maneuvering Flight  MIL-F-8785C Sec 3.2.3.2')
disp(' ')
disp(' ')
echo on
%FQPitch1(CL_q,Cm_q,Cm_de,Cm_0,Cm_alpha,CL_0,CL_alpha,...
%CL_de,W,rho,S_w,c_w,U1,n,g)
%Given inputs load factor (n) and speed (U1) FQPitch1 calculates angle of
%attack and elevator deflection at trim and the change in angle of attack
%and elevator required to reach load factor n.
%
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
%
%Cm_q - variation of aircraft pitching moment with pitch rate
%Cm_de - variation of pitching moment with elevator deflection (1/rad)
%Cm_0 - pitching moment coefficient at zero angle of attck
%Cm_alpha - variation of pitching moment with angle of attack (1/rad)
%CL_0 - lift coefficient for zero angle of attack 
%CL_alpha -variation of lift coefficient with angle of attacke (1/rad)
%CL_de - variation of lift coefficient with elevator deflection (1/rad)
%Cl_alpha_h - 2-D Lift curve slope of horizontal tail
%W - Weight (lbs)
%rho - air density slugs/ft^3
%S_w - Wing area (ft^2)
%c_w - Wing Chord (ft)
%U1 - Trim Speed (ft/s)
%n - Load Factor
%g - gravity (ft/s^2)
echo off
format compact
disp('Function Inputs')
disp('CL_q')
disp(constant(32))
disp('Cm_q')
disp(constant(49))
disp('Cm_de')
disp(constant(47))
disp('Cm_0')
disp(constant(45))
disp('Cm_alpha')
disp(constant(46))
disp('CL_0')
disp(constant(28))
disp('CL_alpha')
disp(constant(29))
disp('CL_de')
disp(constant(30))
disp('Weight (lbs)')
disp('W')
rho
S_w
c_w
velocities
n_vector
disp('Gravity (ft/s^2)')
disp(constant(2))

disp('User Inputs')
de_max
de_min
%Constants for V-n diagram
max_n
min_n
CL_max

format loose