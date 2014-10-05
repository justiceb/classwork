function [q_sim t_sim1 alpha_sim t_sim2 level]=FQPitch2(de,Lsys,y1,sim_run_time)
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

%Run Linear Simulation
%[q_sim,t_sim1]=step(de*Lsys(3,1),sim_run_time);
%[alpha_sim,t_sim2]=step(de*Lsys(7,1),sim_run_time);
%y1=[U,V,W,P,Q,R,Phi,Theta,Psi,Xprime,Yprime,Hprime,Vt,alpha,beta,gamma,Xdot,Ydot,Hdot];

[q_sim,t_sim1]=step(de*Lsys(1,1),sim_run_time);
[alpha_sim,t_sim2]=step(de*Lsys(2,1),sim_run_time);

%Add Reference Values
q_sim=q_sim+y1(5);
alpha_sim=alpha_sim+y1(14);

rate_at_2= interlim1(t_sim1,q_sim,2);
if abs(rad2deg(rate_at_2))>24
    level =1;
elseif abs(rad2deg(rate_at_2)) < 24 && abs(rad2deg(rate_at_2)) > 5
    level=2;
else 
    level=3;
end