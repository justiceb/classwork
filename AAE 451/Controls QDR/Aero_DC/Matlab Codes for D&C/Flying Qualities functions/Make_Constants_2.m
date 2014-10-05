% *********************************************
% Make_Constant    Version 9.1 3/23/05
% This version uses the new Cl_beta code from Barnes McCormick
%
% OBJECTIVES: 1. Determine a set of derived constants that are 
%                used by the stability and control derivative functions.
%             2. Runs each of the stability derivitives functions
%                and sets up the array called constant that is used by other
%                MATLAB programs to perform various dynamic analysis.
%
% INPUTS: Many basic constants defined in the Matlab workspace.
% OUTPUTS: The array called constant of length 67.
% IMPORTANT NOTE: This script is INDEPENDENT of the particular aircraft being modeled.
%
%
% This version corrects Cl_beta, Cy_beta, and Cn_beta.
% This version corrects Cm_alpha, rudder control power, units, and comments.
% AAE565 Spring 2003
%
% *********************************************     
%
% A&AE 565 Spring 2003 - Purdue University
% 
% Note: This code is provided for a first order approximation of the dynamic 
%       stability and control derivatives of an airplane.
%
% Equations/Figures can be found in :
% 
% (Ref.1) Roskam, Jan. "Airplane Flight Dynamics and Automatic Flight
%         Controls"
%         Published by DARcorporation
%         120 E. Ninth St., Suite 2
%         Lawarence, KS 66044
%         Third Printing, 2001.
%
% (Ref.2) Roskam, Jan. "Methods for Estimating Satbility and
%         Control Derivatives of Conventional Subsonic Airplanes"
%         Published by the Author 
%         519 Boulder 
%         Laurance, Kansas 66044
%         Third Printing, 1997.
%  
% (Ref.3) Roskam, Jan. "Airplane Design: Part VI: Preliminary Calculation
%         of Aerodynamic, Thrust and Power Characteristics"
%         Published by Roskam Aviation and Engineering Corporation
%         Rt4, Box 274
%         Ottawa, Kansas 66067
%         Second Printing, 1990.
%
% Ref: Barnes W. McCormick, Aerodynamics, Aeronautics, and Flight mechanics, Second Edition
%      John Wiley and Sons, Inc. 1995, pages 529-534 (used fror Cl_beta_Mc)

U1 = U*1.687808;   	    		% Trim flight speed [ft/s]
[temp,press,rho,Hgeopvector]=atmosphere4(altitude,1);
R=1716.55;	%ft^2/(sec^2degR)
gamma=1.4;  %Air
speed_sound=sqrt(gamma*R*temp);
M=U1/speed_sound;

AR_v = b_v^2/S_v;               % Aspect Ratio of Vertical Tail
AR_h = b_h^2/S_h;				% Aspect Ratio of Horizontal Tail
AR_w = b_w^2/S_w;               % Aspect Ratio of Horizontal Tail
B=sqrt(1-M^2*(cos(Lambda_c4))^2); % Compressibility correction factor
beta = sqrt(1-M^2);             % Compressibility correction factor
Beta = beta;                    % Compressibility correction factor
ca_cw = c_a/c_w;                % Ratio of aileron chord to wing chord
ce_ch = c_e/c_h;				% Elevator flap chord 
cr_cv			= c_r/c_v;      % Rudder flap chord 
eta_ie = b_h_ie/(b_h/2);	  	% Percent span position of inboard edge of elevator
eta_ir		= b_v_ir/b_v;       % Percent span position of inboard edge of rudder
eta_oe = b_h_oe/(b_h/2);		% Percent span position of outboard edge of elevator
eta_or		= b_v_or/b_v;       % Percent span position of outboard edge of rudder
kappa=Cl_alpha/(2*pi);          % Ratio of 2D lift coefficient to 2pi for the wing
kappa_h = Cl_alpha_h/(2*pi);	% Ratio of 2D lift coefficient to 2pi for the horiz. tail
kappa_v		= Cl_alpha_v/(2*pi);  % Ratio of 2D lift coefficient to 2pi for the vert. tail
Xh=Xach-Xref;         			% Distance from airplane arbitrary reference point to the horizontal tail ac [ft]
V_h = (Xh*S_h)/(c_w*S_w);       % Horizontal Tail Volume Coefficient.
Xw=Xacw-Xref;					% Distance from arbitrary ref point to aero center of wing alone. [ft]
l_h=Xach-.25*c_w;				% Distance from AC of Horizontal tail and wing c/4 (ft), positive aft.
delta_f = delf;         		% Streamwise flap deflection [rad] - same as delf
Gamma = dihedral;				% This is the geometric dihedral angle, positive for 
%								dihedral, negative for anhedral [rad]
lambda_w = lambda;     			% Taper ratio of wing again
S_b = S_b_s;           			% Body side area [ft^2] again
x_AC_vh=x_over_c_v*c_v;     	% X distance from LE of vertical tail to AC of horizontal tail [ft]

nu=nufun(altitude);             % Kinematic viscosity, ft*ft/sec

Rl_f= U1*l_f/nu;    			% Reynolds number of fuselage [non-dimensional]
l_b = l_f;	           			% Total length of fuselage [ft]
qbar=.5*rho*U1*U1;     %lbf/ft^2
CL=W/(qbar*S_w);
Cd = Cd_0 + (CL^2/(pi*AR_w*e));   % Drag Coefficient
