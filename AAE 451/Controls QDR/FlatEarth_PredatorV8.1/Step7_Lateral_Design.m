% Step7_lateral_Design.m   Version 8.0 1/23/03
% 
% OBJECTIVE: Set up linear models for use in linear control system design
%            for the lateral-directional subsystem
% INPUTS: The file modelLat.mat created by Step5_Linearize_MATLABx.m
% OUTPUTS: Many transfer functions, poles, natural frequencies and 
%          damping ratios in the MATLAB command window. Also several linear
%          time invariant systems are created in the MATLAB workspace f
%          or subsequent analysis (LDsys, LDtfsys, LDzpksys).
% NOTES: 1. This code can be run after Step5_Linearize_MATLABx.m has been run.
%        2. This code clears memory at the start if execution


clear all
close all
disp(' '); disp('>>>>>>Start here<<<<<<<'); disp(' ');
disp(' Note: memory is cleared at the start of this script'); disp(' ')
load modelLat aLD bLD cLD dLD Vt Hp aircraft % Load lateral directional subsystem linear model
%whos
disp(aircraft)
Vt
Hp
LDsys=ss(aLD,bLD,cLD,dLD);
set(LDsys,'statename',{'v(f/s)' 'p(r/s)' 'r(r/s)' 'phi(r)' 'psi(r)'})
set(LDsys,'inputname',{'deltaA(r)' 'deltaR(r)'})
set(LDsys,'outputname',{'v(f/s)' 'p(r/s)' 'r(r/s)' 'phi(r)' 'psi(r)' 'beta(r)'})
LDsys
[Wn,Z,Poles]=damp(LDsys)
LDtfsys=tf(LDsys)
LDzpksys=zpk(LDsys)

% select r/Dr transfer function (3 output and 2 input)
%io=3
%ic=2
%LDsys2=ss(aLD,bLD(:,ic),cLD(io,:),dLD(io,ic));
%set(LDsys2,'statename',{'v(f/s)' 'p(r/s)' 'r(r/s)' 'phi(r)' 'psi(r)'})
%set(LDsys2,'inputname','deltaR(r)')
%set(LDsys2,'outputname','r(r/s)')
%LDsys2
%[Wn2,Z2,Poles2]=damp(LDsys2)
%LDtfsys2=tf(LDsys2)
%LDzpksys2=zpk(LDsys2)

