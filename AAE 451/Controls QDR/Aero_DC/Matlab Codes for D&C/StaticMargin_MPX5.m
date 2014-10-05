disp(' '); disp('Start Here <<<<<<<<<<<<<<<<<<<<<<<<'); format compact
disp('INPUTS')
aircraft='MPX5'    % Name of the aircraft
W = 19.2           % Weight of Airplane [lbf]
S_w = 1350/144     % Surface area of wing [ft^2]
altitude= 607      % Trim altitude [ft]
c_w = 15/12        % Mean aerodynamic chord of the wing [ft]
Iyy = 1.10         % Airplane moment of inertia about y-axis [slug-ft^2]
g=32.17            % accel of gravity (ft/sec^2)
Xref = 0.25*c_w    % Distance from the leading edge of the wing mean aerodynamic chord
% to the arbitrary moment reference point. The equivalent force system
% for the aerodynamic force system is given about this point.
% Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Xcg =  0.25*c_w       % Distance from the leading edge of the wing mean aerodynamic chord
% to the center of gravity. 
% Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]        
% CL_alpha
CL_alpha= 4.84
% Cm_alpha where Xref is the moment reference point.
Cm_alpha= -1.13
% Cm_q  where Xref is the moment reference point.
Cm_q= -11.9


disp(' '); disp('OUTPUTS')
rho=rhofun(altitude)			% Air density at altitude [slug/ft^3]
Xbarcg=Xcg/c_w;;   % XbarCG,  nondimensional, measured aft from leading edge of wing mean aerodynamic chord.
%Xbarcg=.15
Xbarref=Xref/c_w;  % XbarRef, nondimensional, measured aft from leading edge of wing mean aerodynamic chord.
Xbarac=-Cm_alpha/CL_alpha+Xbarref;
StaticMargin=Xbarac-Xbarcg;
stringA=['C.G. location,               Xbarcg= ',num2str(Xbarcg),' (fraction of chord)'];
stringB=['Aerodynamic center location, Xbarac= ',num2str(Xbarac),' (fraction of chord)'];
stringC=['Static Margin      (Xbarac-Xbarcg) = ',num2str(StaticMargin),' (fraction of chord)'];
disp(stringA); disp(stringB); disp(stringC); 
string4=['Typically 0.05 to 0.50 of the reference chord.'];
disp(string4)
disp('NOTE: static margin above is relative the the c.g.')

disp('See Roskam 421 book pages 431-434 for discussion of Control Anticipation Parameter (CAP).')
ManeuverMargin=StaticMargin-g*rho*S_w*c_w*Cm_q/(4*W)   % in fractions of wing chord (eqn 6.10 p. 433)
% StickFixedNeutralPoint=Xbarcg+StaticMargin % Same as Aerodynamic center
ManeuverPoint=Xbarac-g*rho*S_w*c_w*Cm_q/(4*W)   %Eqn 6.11 p.433
CAP=W*c_w*ManeuverMargin/Iyy

MinimumCAP=5.92 % This is the requirement from Mark Peters' thesis
disp(' ')
disp('According to Mark Peters'' MS thesis Level 1 flying qualities ')
disp(['for small model airplanes requires that CAP>',num2str(MinimumCAP),'.']);
disp('For this to happen the static margin (SM) must be greater than or equal to the following')
SMminimum=MinimumCAP*Iyy/(W*c_w)+g*rho*S_w*c_w*Cm_q/(4*W)  % in fractions of wing chord
disp('and the cg must be forward of the following point')
disp('(expressed in fractions of the Cbar meaured aft from the leading edge of the wing).')
MostAftCG=Xbarac-SMminimum
if(CAP>MinimumCAP)
    disp('This aircraft meets Level 1 flying qualities for CAP')
else
    disp('This aircraft does not meet Level 1 flying qualities for CAP.')
end
