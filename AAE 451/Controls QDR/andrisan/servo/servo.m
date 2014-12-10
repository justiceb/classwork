%clear
%disp('Start Here')
% SYS = TF(NUM,DEN)
num=[950] 
den=[1,40,950] 
system=tf(num,den) 
poles=roots(den)
%[Wn,Z] = DAMP(SYS)
[Wn,Z] = damp(system)
%[MAG,PHASE,W] = bode(system)
bode(system)
%
% Measured rate limit
servoRL=252 %Servo rate limit, degree per second
%
% Catalog specifications transit time .22 sec/60 degrees
% Rate limit
servoRLCatalog=60/.22 % degrees per second (272.727)
%


