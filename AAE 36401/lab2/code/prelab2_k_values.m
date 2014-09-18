p3 = -10
p4 = -20
K = place (A,B,[(-1.8182+1.9067i), (-1.8182-1.9067i), p3, p4])


close all

Ai = [A, zeros(4, 1);-1, 0, 0, 0, 0]
Bi = [B; 0]

p3 = -10
p4 = -20
p5 = -30
K = place (Ai,Bi,[(-1.8182+1.9067i), (-1.8182-1.9067i), p3, p4, p5])
sim('aae364gantry2')
figure(1)
plot(p_out.Time,p_out.Data)
hold all
figure(2)
plot(alpha_out.Time,alpha_out.Data)
hold all
p_properties = stepinfo([0;p_out.Data],[0;p_out.Time],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
alpha_properties = stepinfo([0;alpha_out.Data],[0;alpha_out.Time],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)

PO = 3;
ts = 1.5;
damping = abs(log(PO/100))/sqrt(log(PO/100)^2+pi^2)
wn = 4/(ts*damping)
poly2 = [1 2*damping*wn wn^2];
r = roots(poly2)
p1 = r(1);
p2 = r(2);
K = place (Ai,Bi,[p1, p2, p3, p4, p5])
sim('aae364gantry2')
figure(1)
plot(p_out.Time,p_out.Data)
grid on
legend('ts = 2.2; PO = 5','ts = 1.5; PO = 3',0)
xlabel('time (s)')
ylabel('cart position (m)')
figure(2)
plot(alpha_out.Time,alpha_out.Data)
grid on
legend('ts = 2.2; PO = 5','ts = 1.5; PO = 3',0)
xlabel('time (s)')
ylabel('alpha (deg)')
p_properties = stepinfo([0;p_out.Data],[0;p_out.Time],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)
alpha_properties = stepinfo([0;alpha_out.Data],[0;alpha_out.Time],0.5,'RiseTimeLimits',[0 1],'SettlingTimeThreshold',0.05)



