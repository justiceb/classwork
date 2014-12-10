addpath FlatEarth-9.53

clear all; close all; format short g
Basic_Constants_T12b
Make_Constants  % Creates the array called constant used to define the aerodynamics and mass properties of the aircraft.
Check_Constants % Check the constants for believability.
Step2_Trim
Step3_Simulate_Trim
Step4_Plot_Trim  %(optional step)
Step5_Simulate_Perturbations
Step6_Plot_Perturbations  %(optional step)
Step7_Linearize_and_Overplot

%pull out Xfer function we want
[z,p,k] = zpkdata(Lsys(3,1));  % From input "deltaE(r)" to output "q(r/s)"
NUM = poly(z{1})*k;
DEN = poly(p{1});
xfer = tf(NUM,DEN)

K = -3;
[R,~] = rlocus(-xfer,-K)
rlocus(-xfer,-K)
sim('Longitudinal_Stability_Model')
t = simout.Time;
q = simout.Data;
figure(10)
plot(t,q*57.2957795)
xlabel('time (s)')
ylabel('Pitch Rate Q (deg/s)')
grid on
hold all


