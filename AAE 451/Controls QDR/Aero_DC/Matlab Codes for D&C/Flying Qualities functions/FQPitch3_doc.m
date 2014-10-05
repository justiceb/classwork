%FQPitch3 Doc
disp(' ')
disp(' ')
disp('<<<<<<<<<<<Executing FQPitch3 - Longitudinal Control During Takeoff MIL-F-8785c  Sec 3.2.3.3')
disp(' ')
disp(' ')
echo on
%[R U_dot theta_dotdot_mg]=FQPitch3(CL_0_h, CL_0_wf, CL_alpha_h, CL_de_h, bhp_max, de,...
%rho, Cd, Cl_alpha_wf, Cm_0, Cm_alpha, Cm_de,...
%tail_down_angle,U1, S_w, S_h,x_m, Xref, Xcg, W, c_w, mu_mg, g, eta,...
%z_cg, Iyy, Xacwb, Xach, x_mg_rot, z_d, z_t, i_w, i_h,class,gear_type)
%Calculate main gear reaction force, aircraft acceleration, and rotational
%acceleration during takeoff roll.
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
% CL_0_h - lift coefficient for zero angle of attack of horizontal tail
% CL_0_wf - lift coefficient for zero angle of attack of wing/fuselage
% CL_alpha_h -variation of lift coefficient with angle of attack horizontal tail (1/rad)
% CL_de_h variation of lift coefficient with elevator deflection horizontal tail (1/rad)
% bhp_max - Maximum engine bhp
% de - Elevator deflection (rad)
% rho - Air density (slugs/ft^3)
% Cd - Drag Coefficient
% CL_alpha_w - -variation of lift coefficient with angle of attack wing/fuselage (1/rad)
% Cm_0 - pitching moment coefficient at zero angle of attack
% Cm_alpha - variation of pitching moment with angle of attack (1/rad)
% Cm_de - variation of pitching moment with elevator deflection (1/rad)
% ground_roll_angle - Tail-down angle of aircraft on runway (deg)
% U1 - Aircraft speed (ft/sec)
% S_w - Wing area (ft^2)
% S_h - Horizontal tail area (ft^2)
% x_m -Distance from nose of aircraft to arbitrary reference point [ft]
%      measured positive aftward.
% Xref - Distance from the leading edge of the wing mean aerodynamic chord
%        to the arbitrary moment reference point. The equivalent force system
%        for the aerodynamic force system is given about this point.
%        Measured as positive aft,starting from the leading edge of 
%        the mean aero. chord. [ft]
% Xcg - Distance from the leading edge of the wing mean aerodynamic chord
%       to the center of gravity. Measured as positive aft, starting 
%       from the leading edge of the mean aero. chord. [ft]
% W - Aircraft weight (lb)
% c_w - Wing cord (ft)
% mu_mg - Coefficient of friction wheel-concrete
% g - gravity (ft/sec^2)
% eta - propeller efficiency
% z_cg - Landing Gear height above ground (ft)
% Iyy - Airplane moment of inertia about y-axis [slug-ft^2]
% Xacwb - % Distance from the leading edge of the wing mean aerodynamic chord
%           to the aerodynamic center of the wing and body. 
% Xach - Distance from the leading edge of the wing mean aerodynamic chord
%        to the aerodynamic center of the horizontal tail
%        (positive aftward) [ft]
% x_mg_rot - Distance from leading edge of wing to main gear (ft)
% z_d - Resultant Drag vertical distance above ground (ft)
% z_t - Engine thrust vertical distance from ground (ft)
% i_w - incidence angle of wing [rad]
% i_h - incidence angle of horizontal tail [rad]
% class - Aircraft class
% gear_type - Landing gear type
%             Gear Type = 1 Tricycle 
%             Gear Type = 2 Taildragger
echo off
format compact
disp('Function Inputs')
CL_0_h
CL_0_wf
CL_alpha_h
CL_de_h
bhp_max
de
rho
Cd
CL_alpha_w
disp('Cm_de')
disp(constant(47))
disp('Cm_0')
disp(constant(45))
disp('Cm_alpha')
disp(constant(46))       
ground_roll_angle
U1_vec(k)
S_w
S_h
x_m
Xref
Xcg
W
c_w
mu_wg
g
disp('eta_p')
disp(constant(8))
z_cg 
Iyy
Xacwb
Xach
x_mg_rot
z_d
z_t 
i_w
i_h
class
gear_type

disp('User Inputs')
de_deg
CL_max
class
gear_type
ground_roll_angle
mu_wg
z_cg
x_mg_rot
z_d
z_t
bhp_max
format loose