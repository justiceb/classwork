% Step6_Longitudinal_Design.m  Version 8.0 1/23/03
% 
% OBJECTIVE: Set up linear models for use in linear control system design
%            for the longitudinal subsystem
% INPUTS: The file modelLong.mat created by Step5_Linearize_MATLABx.m
% OUTPUTS: Many transfer functions, poles, natural frequencies and 
%          damping ratios in the MATLAB command window. Also several linear
%          time invariant systems are created in the MATLAB workspace f
%          or subsequent analysis (Lsys, Ltfsys, Lzpksys).
% NOTES: 1. This code can be run after Step5_Linearize_MATLABx.m has been run.
%        2. This code clears memory at the start if execution

clear all
close all
disp(' '); disp('>>>>>>Start here<<<<<<<'); disp(' ');
disp(' Note: memory is cleared at the start of this script'); disp(' ')
load modelLong aL bL cL dL Vt Hp aircraft % Load lateral directional subsystem linear model
disp(aircraft)
Vt
Hp
Lsys=ss(aL,bL,cL,dL);
set(Lsys,'statename',{'u(f/s)' 'w(f/s)' 'q(r/s)' 'thet(r)' 'h(f)'})
set(Lsys,'inputname',{'deltaE(r)' 'Bhp(hp)'})
set(Lsys,'outputname',{'u(f/s)' 'w(f/s)' 'q(r/s)' 'thet(r)' 'h(f)' 'Vt(f/s)' 'alf(r)' 'gam(r)'})
Lsys
[Wn,Z,Poles]=damp(Lsys)
Ltfsys=tf(Lsys)
Lzpksys=zpk(Lsys)
