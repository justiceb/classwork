%FQyaw2 Doc
disp(' ')
disp(' ')
disp('<<<<<<<<<<<Executing FQYaw1 - Lat. Dir. Control w/ Asymmetric Thrust - MIL-F-8785C Sec 3.3.7')
disp(' ')
disp(' ')
echo on
%[level]=FQYaw1(W,rho,U1,S_w,b_w,Cyb,Cyda,Cydr,Clb,Clda,Cldr,Cnb,Cnda,Cndr,
%gamma,FyT1,LT1,NT1,DND1,max_dr,max_da)
%Calculate required rudder and aileron for zero sideslip in an asymmetric
%thrust situation. 
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
%W - Aircraft weight (lbs)
%rho - air density slugs/ft^3
%U1 - Trim Flight Speed (ft/sec)
%S_w - Reference Wing Area (ft^2)
%b_w - Reference Wing Chord (ft)
%Cyb - Variation of airplane side force coefficient with dimensionless rate
%      of change of angle of sideslip (1/rad)
%Cyda - Variation of side force coefficient with aileron angle (1/rad)
%Cydr - Variation of side force coefficient with rudder angle (1/rad)
%Clb - Variation of rolling moment coefficient with angle of sideslip
%       (1/rad)
%Clda - Variation of rolling moment coefficient with aileron angle (1/rad)
%Cldr - Variation of rolling moment coefficient with rudder angle (1/rad)
%Cnb - Variation of yawing moment coefficient with angle of sideslip(1/rad)
%Cnda - Variation of yawing moment coefficient with aileron angle (1/rad)
%Cndr - Variation of yawing moment coefficient with rudder angle (1/rad)
%gamma - Flight Path Angle (deg)
%LT1 - Moment due to Thrust about X (ft-lbf);
%NT1 - Moment due to Thrust about Z (ft-lbf);
%FyT1 - Thrust Force Component along Y (ft-lbf);
%DND1 - Additional yawing moment due to drag from failed engine 
%   NOTE: The contribution of DND1 may be estimated by using NT1=FOEI*NT1
%         and setting DND1=0. See table below [Roskam]
%Type of Power Plant    Fixed Pitch  Variable Pitch    Low BPR     High BPR
%FOEI                       1.25          1.10           1.15         1.25
%max_dr - Maximum Rudder Deflection (Degrees)
%max_da - Maximum Aileron Deflection (Degrees)
echo off
format compact
disp('User Inputs')
W
rho
U1
S_w
b_w
disp('Cyb')
constant(34)
disp('Cyda')
constant(35)
disp('Cydr')
constant(36)
disp('Clb')
constant(40)
disp('Clda')
constant(41)
disp('Cldr')
constant(42)
disp('Cnb')
constant(51)
disp('Cnda')
constant(52)
disp('Cndr')
constant(53)
gamma
FyT1
LT1
NT1
DND1
max_dr
max_da

format loose
