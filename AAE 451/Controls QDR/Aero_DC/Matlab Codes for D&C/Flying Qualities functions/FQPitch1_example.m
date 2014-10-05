clear all;clc;close all
Basic_Constants_MPX5;
Make_Constants;
%% User Inputs
de_max=20; %maximum aileron deflection (deg)
de_min=-20; %minimum aileron deflection (deg)
%Constants for V-n diagram
max_n=3; %Maximum Load Factor
min_n=-1; %Minimum Load Factor
CL_max=1.4; %define CL_max

%% Calculations
V_stall=sqrt(2*W/(rho*CL_max*S_w)); %Calculate Stall Speed (ft/sec)
%cruise speed = kc*sqrt(W/S_w) kc=36 for acrobatic Ref Roskam Airplane
%Aerodynamics and Performance
V_cruise=36*sqrt(W/S_w); %(ft/sec)
%Dive Speed V_d>=1.25*V_cruise
V_dive=1.5*V_cruise; %(ft/sec)

U1_a=0:.1:300; %Set Velocity vecotor for V_n diagram 

%% Create V_n diagram

n_u_stall=(0.5.*rho.*U1_a.^2.*CL_max*S_w)./W; %create upper stall line
plot(U1_a(1:find(n_u_stall>max_n,1,'first')),n_u_stall(1:find(n_u_stall>max_n,1,'first')),'r')
hold on

U1_b=[U1_a(find(n_u_stall>max_n,1,'first')) V_dive];
n_b=[max_n,max_n]; %maximum load factor line
plot(U1_b,n_b,'r')

U1_c=[V_dive V_dive];
n_c=[max_n,min_n]; %max speed line
plot(U1_c,n_c,'r')

n_d=(0.5.*rho.*U1_a.^2.*CL_max*S_w)./W; %negative stall line
plot(U1_a(1:find(n_d>1,1,'first')),-n_d(1:find(n_d>1,1,'first')),'r')

U1_e=[U1_a(find(n_d>1,1,'first')) V_dive]; %min load factor line
n_e=[-1,-1];
plot(U1_e,n_e,'r')


grid on;
plot([0 V_dive],[1 1],'--r','LineWidth',1.5) %Trim line
text(0, 1.2,'Trim Line')
%% Maneuver Calculations
%Set elevator deflection range to plot
de_plot=deg2rad(de_min):deg2rad(5):deg2rad(de_max);
%set vecotor of load factors for calculations
n_vector=-10:.2:10; 
%set vector of velocities for calculations
velocities=V_stall:1:V_dive; %ft/sec 
%Initialize variables
alpha_trim=zeros(length(velocities),length(n_vector));
de_trim=zeros(length(velocities),length(n_vector));
d_alpha=zeros(length(velocities),length(n_vector));
d_de=zeros(length(velocities),length(n_vector));
de=zeros(length(velocities),length(n_vector));
n_at_constant_de=zeros(1,length(velocities));
%% Display Function Document
FQPitch1_doc;
%% Create 2D tables
%Given N and Velocity, give a 2D table for elevator deflection from trim
%and a 2D table for angle of attack from trim.
for jj=1:length(de_plot)
    for j=1:length(velocities)
        for k=1:length(n_vector);
            %Call FQPitch1 to find change in alpha and change in elevator 
            %deflection from trim (d_alpha d_de)
            %Set overides for Make_Constants
            U1 = velocities(j);
            U = U1/1.687808; 
            Make_constants_2
            [alpha_trim(j,k) de_trim(j,k) d_alpha(j,k) d_de(j,k)]=FQPitch1(constant(32),constant(49),constant(47),constant(45),constant(46),constant(28),constant(29),constant(30),W,rho,S_w,c_w,velocities(j),n_vector(k),constant(2));
            %Calculate total elevator deflection
            de(j,k)=d_de(j,k)+de_trim(j,k);
        end
        %Calculate load factor at constant elevator deflection
        n_at_constant_de(j)=interp1(de(j,:),n_vector,de_plot(jj));

    end
    %Plot Lines of Constant Elevator Deflection
    plot(velocities,n_at_constant_de)
    string=[' ' num2str(rad2deg(de_plot(jj))) '^\o'];
    text(velocities(length(velocities)),n_at_constant_de(length(n_at_constant_de)),string)
end
xlabel('V (fps)')
ylabel('n')
title('Load Factor vs Velocity vs w/ Lines of Constant Total Elevator Deflection')
%Calculate elevator deflection and angle of attack at trim for all velocities
fun_de_trim=interp2(n_vector,velocities,de_trim,1,velocities); 
fun_alpha_trim=interp2(n_vector,velocities,alpha_trim,1,velocities);
figure
plot(velocities,rad2deg(fun_de_trim))
xlabel('Velocity (ft/sec)')
ylabel('Elevator Deflection (deg)')
title('Elevator Deflection vs Velocity at Trim (n=1)')
figure
plot(velocities,rad2deg(fun_alpha_trim))
xlabel('Velocity (ft/sec)')
ylabel('Angle of Attack (deg)')
title('Angle of Attack vs Velocity at Trim (n=1)')

figure
hold on
%Create load factor vector for plot
n_plot=min_n:.5:max_n;
format short
for kk=1:length(n_plot)
    %Calculate delta elevator deflection from trim for constant load factor
    de_required=interp2(n_vector,velocities,d_de,n_plot(kk),velocities);
    plot(velocities,rad2deg(de_required));
    string=[' n=' num2str(n_plot(kk))];
    text(velocities(1),rad2deg(de_required(1)),string,'FontSize',12,'FontWeight','Bold')
end
title('Change in Elevator Deflection from Trim vs Speed w/ Lines of Constant Load Factor')
xlabel('Velocity (ft/s)')
ylabel('\Delta\deltae From Trim(deg)')
grid on;



