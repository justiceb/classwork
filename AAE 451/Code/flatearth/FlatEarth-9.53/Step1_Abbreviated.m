% Step1_Abbreviated.m    Version 9.51 1/25/2010
%
% Specify Mathematical Model of the Aircraft if you already know the array
% called constant.
%
% This script assumes that the array called constant has been computed by
% some means. If this is not true use the script
% Step1_Math_Model.m

disp(' '); disp('Start Here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<')
aircraft='MPX-5 (See Masters Thesis of Mark Peters,1996)';
disp(aircraft); % Display aircraft identification

% The array called constant is the only output of Step 1 and serves to
% define the specific vehicle being analyzed.

constant =[19.2000   32.1466    0.5973    0.7690    1.1000    1.8400         0    0.6500         0    1.4150   -0.9623         0 ...
            1.3004         0    0.9736         0    0.9091   -0.1799    0.5435    9.3750    1.2500    7.5000         0         0 ...
            0.0267    0.0680         0    0.1474    4.0865    0.4340    1.4165    4.7176         0   -0.2663         0    0.1497 ...
           -0.0415    0.1901         0   -0.0532    0.2082    0.0150   -0.5916    0.2854   -0.0300   -1.1008   -1.2132   -1.1540 ...
           -10.8418    0        0.0704   -0.0189   -0.0691   -0.0410   -0.0948    0.2500    0.2500   64.0000         0         0 ...
              0        0         0         0         0         0         0];

Check_Constants % Check the constants for believability.
disp(aircraft); % Display aircraft identification