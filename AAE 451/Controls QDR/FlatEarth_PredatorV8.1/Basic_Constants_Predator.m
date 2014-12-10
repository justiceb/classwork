% *********************************************
% BasicConstants_Predator   Version 8.0 1/23/03
%  
% OBJECTIVE: Collect into one location all the vehicle specific constants (a.k.a. basic constants).
%            From these basic constants all the stability and control derivatives 
%            can be determined.
% INPUTS: None
% OUTPUTS: Many basic constants defined in the Matlab workspace.
%

% This version corrects Cl_beta, Cy_beta, and Cn_beta.
% This version corrects Cm_alpha, rudder control power, units, and comments.
% AAE 565 Spring 2003
%
% *********************************************
% BasicConstants - Identifies, describes, and assigns all of the 
%                  the most basic variables for analyzing the control
%                  and stability of a generic aircraft.
% *********************************************     
% 
% A&AE 565 Spring 2003 - Purdue University
% 
% Note: This code is provided for a first order approximation of the dynamic 
%       analysis of an airplane and is not intended for final designs.
%
% Equations/Figures can be found in :
% 
% (Ref.1) Roskam, Jan. "Airplane Flight Dynamics and Automatic Flight
%         Controls"
%         Published by DARcorporation
%         120 E. Ninth St., Suite 2
%         Lawrence, KS 66044
%         Third Printing, 2001.
%
% (Ref.2) Roskam, Jan. "Methods for Estimating Stability and
%         Control Derivatives of Conventional Subsonic Airplanes"
%         Published by the Author 
%         519 Boulder 
%         Lawrence, Kansas 66044
%         Third Printing, 1997.
%  
% (Ref.3) Roskam, Jan. "Airplane Design: Part IV: Preliminary Calculation
%         of Aerodynamic, Thrust and Power Characteristics"
%         Published by Roskam Aviation and Engineering Corporation
%         Rt4, Box 274
%         Ottawa, Kansas 66067
%         Second Printing, 1990.
%
disp(' '); disp(' Starting BasicConstants'); disp(' ')
aircraft='Predator A, unmanned aerial vehicle';
adelf = 0;           	% Two dimensional lift effectiveness parameter Ref.(2),Equ(8.7)
alpha = 0*pi/180;     % Trim Angle of attack [rad]. This should be zero since our
%					  equations of motion are body axis system rather then the stability axis system.
alpha_0 = -2*pi/180;	        % Airfoil zero-lift AOA [rad]
altitude= 10000;		% Trim altitude [ft]
disp(['Trim altitude= ',num2str(altitude),' ft'])
AR_h = 3.966;        		% Aspect ratio of the horizontal tail
AR_w = 7.978;      	% Aspect ratio of the wing
b_f = 24.7;         	% Span of the flap [ft]
b_h = 12.5;   		% Span of the horizontal tail [ft]
b_h_oe = 3.6111;        	% Elevator outboard position [ft]
b_h_ie = 0.8333;  		% Elevator inboard position [ft]
b_w = 38;          	% Span of the wing [ft]
b_v = 5.417;          	% Vertical tail span measured from fuselage centerline[ft]
b_v_or = 2.778;      	    % Outboard position of rudder [ft]
b_v_ir = 0.2777;     		% Inboard position of rudder [ft]
c_a = 1.111;           	% Chord of aileron [ft]
C_bar_D_o = 0.0267;       % Parasite drag
Cd_0 = 0.0267;       	% Drag coefficient at zero lift (parasite drag)
c_e = 1.806;	         	% Elevator chord [ft]
cf = 1.111;          	    % Chord of the wing flap [ft]
c_h = 3.056;          	% Mean aerodynamic chord of the horizontal tail [ft]
CL = 0.345;        	% Lift coefficient (3-D)
CL_hb = 0;          	% Lift coefficient of the horzontal tail/body
CL_wb= 0.3625;	     	    % Lift coefficient of the wing/body - assuming iw=0
Cl_alpha_h = 3.5;		% 2-D Lift curve slope of horizontal tail
Cl_alpha_v = 3.5;  	    % 2-D Lift curve slope of vertical tail
Cl_alpha = 3.5;     	% Two-dimensional lift curve slope of whole aircraft
Cl_alpha_w = 3.5;   	% Two-dimensional lift curve slope of wing
Cm_0_r = -0.04;   	    % Zero lift pitching moment coefficient of the wing root
Cm_o_t = -0.04;      	    % Zero lift pitching moment coefficient of the wing tip
c_r =  0.694;         	% Chord of the rudder [ft]
c_w = 5.0625;         	% Mean aerodynamic chord of the wing [ft]
c_v = 0.97225;           	% Mean aerodynamic chord of the vertical tail [ft]
D_p = 6.333;          % Diameter of propeller [ft]
d = 2.222;				% Average diameter of the fuselage [ft]
delf = 0;             % Streamwise flap deflection [rad] 
delta_e = 0;	    	% Elevator deflection [rad]
delta_r = 0;          % Rudder deflection [rad]
dihedral = 6.5*pi/180;    % Geometric dihedral angle of the wing [rad], positive for 
%						   dihedral (wing tips up), negative for anhedral(tips down) [rad]
dihedral_h = 0*pi/180;       % Geometric dihedral angle of the horizontal tail [rad]
e = 0.573;           % Oswald's efficiency factor
epsilon_t = 0;        % Horizontal tail twist angle [rad]
epsilon_0_h = 0.25*pi/180;     	% Downwash angle at the horizontal tail (see Note in 
%						Ref.(3) under section 8.1.5.2) [rad]
eta_h = 1.298;	      	% Ratio of dynamic pressure at the horizontal tail to that of the freestream 
eta_ia = 0.647;      	    % Percent semi-span position of inboard edge of aileron
eta_oa = 0.958;       	% Percent semi-span position of outboard edge of aileron
eta_p = 0.85;			% Propeller Efficiency
eta_v = 1.298;			% Ratio of the dynamic pressure at the vertical tail 
%						to that of the freestream
h1_fuse = 4.167;       	% Height of the fuselage at 1/4 of the its length 
h2_fuse = 1.667;  	    % Height of the fuselage at 3/4 of the its length 
h_h = 4.444;       	    % Height from chord plane of wing to chord plane of
%						horizontal tail [ft] - Fig 3.7, Ref. 2
hmax_fuse = 4.722;     	% Maximum height of the fuselage [ft]  
Ixx = 7491;          % Airplane moment of inertia about x-axis [slug-ft^2]
Iyy = 1741.5;          % Airplane moment of inertia about y-axis [slug-ft^2]
Izz = 8553.9;         % Airplane moment of inertia about z-axis [slug-ft^2]
Ixz = 0;             % Airplane product of inertia [slug-ft^2]
i_h = 0*pi/180;      % Incidence angle of horizontal tail [rad]  
i_w = 2.2*pi/180;	% Incidence angle of wing [rad]  
k = 0.0697;		    % k of the drag polar, generally= 1/(pi*AR*e)
Lambda = 2.119*pi/180;            % Sweep angle of wing [rad]
Lambda_c2 = 0.4785*pi/180;  % Sweep angle at the c/2 of the wing [rad]
Lambda_c4 = 1.3*pi/180;     % Sweep angle at the c/4 of the wing [rad]     
Lambda_c2_v = 23.49*pi/180;      % Sweep angle at the c/2 of the vertical tail [rad]
Lambda_c4_v = 32.06*pi/180;      % Sweep angle at the c/4 of the vertical tail [rad]
Lambda_c2_h = 0;      % Sweep angle at the c/2 of the horizontal tail [rad]
Lambda_c4_h = 0;      % Sweep angle at the c/4 of the horizontal tail [rad]
lambda = 0.795;     % Taper ratio of wing
lambda_h = 1;    		% Taper ratio of horizontal tail
lambda_v = 0.75;         % Taper ratio of vertical tail
l_f = 25;           	% Horizontal length of fuselage [ft]  
l_v = 13.61;       	    % Horizontal distance from aircraft arbitrary reference point to vertical tail AC [ft]
M = 0.3382;            % Mach number
S_b_s = 64.674;            % Body side area [ft^2]
S_h = 27.5;	            % Area of horizontal tail [ft^2]
S_h_slip = 9.336;	        % Area of horizontal tail that is covered in 
%						prop-wash [ft^2] - See Fig.(8.64) - Ref.(3) 
S_o = 12.5;    	        % Fuselage x-sectional area at Xo [ft^2] - 
%						See Fig.(7.2) - Ref.(2)
% 						Xo is determined by plugging X1/l_b into: 
%						0.378 + 0.527 * (X1/l_b) = (Xo/l_b)
S_w = 181;          % Surface area of wing [ft^2]
S_v = 39.4;   	    % Surface area of vertical tail [ft^2]
tc_w = 0.1467;             % Thickness to chord ratio of wing 
tc_h = 0.0909;             % Thickness to chord ratio of horizontal tail
theta = 0*pi/180;    % Wing twist - negative for washout [rad]
theta_h = 0*pi/180;  % Horizontal tail twist between the root and tip 
%						stations,negative for washout [rad]
two_r_one = 1.111;     	% Fuselage depth in region of vertical tail [ft] Ref.(2),Figure 7.5
%U1(ft/sec) = U(knots)*1.687808;   	    		% Trim flight speed [ft/s]
U = 158;	       	   	% Free Stream Velocity (Trim velocity) [KNOTS true]
%echo on
%U1=180; % ft/sec
%U=U1/1.687808;
%echo off
disp(['Trim airspeed= ',num2str(U),' knots'])
W = 3900;           % Weight of Airplane [lbf]
wingloc = 0;        	% If the aircraft is a highwing: (wingloc=1), low-wing:(wingloc=0) 
wmax_fuse = 29.04;   % Maximum fuselage width [ft]
X1 = 8.889;  	         	% Distance from the front of the fuselage where the 
%						x-sectional area decrease (dS_x/dx) 
%						is greatest (most negative) [ft] - Ref.(2),Fig. 7.2  
x_m = 10.354;        	    % Distance from nose of aircraft to arbitrary reference point [ft]
%						measured positive aftward.
x_over_c_v = 0.9997;  	    % PARAMETER ACCOUNTING FOR THE RELATIVE POSITIONS OF THE HORIZONTAL AND VERTICAL TAILS
%						defined as the fore-and-aft distance from leading edge of vertical fin to the
%						aerodynamic center of the horizontal tail divided by the chord of the vertical tail 
%						[nondimensional] - See Fig 7.6 of Ref. 2 
Xach =15.556;			    % Distance from the leading edge of the wing mean aerodynamic chord
%                       to the aerodynamic center of the horizontal tail (positive aftward) [ft]
Xacwb = 0.25*c_w;     % Distance from the leading edge of the wing mean aerodynamic chord
%                       to the aerodynamic center of the wing and body. 
%						Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Xacw = 0.25*c_w;      % Distance from the leading edge of the wing mean aerodynamic chord
%                       to the aerodynamic center of the wing ALONE. 
%						Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Xref = 0.25*c_w;      % Distance from the leading edge of the wing mean aerodynamic chord
%                       to the arbitrary moment reference point. The equivalent force system
% 						for the aerodynamic force system is given about this point.
%						Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Z_h = -4;        		% Negative of the VERTICAL distance from the fuselage 
%						centerline to the horizontal tail aero center 
%						(Z_h is a negative number FOR TAILS ABOVE THE CENTERLINE)
%						- Ref.(2), Fig.7.6
%						***This produces a bunch of interpolation errors because 
%						Roskam doesn't have data for horizontal tails below the 
%						centerline of the fuselage
Z_v = 2.3;    			% Vertical distance from the aircraft arbirary reference point to the vertical 
%						tail aero center (positive up) - Ref.(2), Fig. 7.18
Z_w = -0.5;	       		% This is the vertical distance from the wing root c/4 [ft]
%						to the fuselage centerline, 
%						positive downward - Ref.(2), Equ(7.5)
Z_w1 = 0.8;	         	% Distance from body centerline to c/4 of wing root 
%						chord,positive for c/4 point
%						below body centerline (ft) - Ref.(2), Fig. 7.1  
