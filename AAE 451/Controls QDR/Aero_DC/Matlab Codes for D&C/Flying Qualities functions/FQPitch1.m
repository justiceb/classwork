function [alpha_trim de_trim d_alpha d_de]=FQPitch1(CL_q,Cm_q,Cm_de,Cm_0,Cm_alpha,CL_0,CL_alpha,CL_de,W,rho,S_w,c_w,U1,n,g)
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
%Cm_0 - pitching moment coefficient at zero angle of attack
%Cm_alpha - variation of pitching moment with angle of attack (1/rad)
%CL_0 - lift coefficient for zero angle of attack 
%CL_alpha -variation of lift coefficient with angle of attack (1/rad)
%CL_de - variation of lift coefficient with elevator deflection (1/rad)
%Cl_alpha_h - 2-D Lift curve slope of horizontal tail
%W - Weight (lbs)
%rho - air density slugs/ft^3
%S_w - Wing area (ft^2)
%c_w - Wing Chord (ft)
%U1 - Trim Speed (ft/s)
%n - Load Factor
%g - gravity (ft/s^2)


q=g*(1-n)/U1; %pitch rate - 1-loadfact/(speed at trim)
q_hat=c_w*q/(2*U1); %nondimensional pitch rate

Cw=2*W/(rho*U1^2*S_w); %CL at trim
a=[CL_alpha CL_de; Cm_alpha Cm_de];
%solve trim equations
trim_values=(a^-1)*[Cw-CL_0; -Cm_0]; 
alpha_trim=trim_values(1); %angle of attack at trim
de_trim=trim_values(2); %elevator delflection at trim
%solve maneuver equations
d_values=([CL_alpha CL_de; Cm_alpha Cm_de]^-1)*[(n-1)*Cw-CL_q*q_hat; -Cm_q*q_hat];
d_alpha=d_values(1); %Change in alpha from alpha trim 
d_de=d_values(2); %Change in elevator deflection from elevator at trim

return
