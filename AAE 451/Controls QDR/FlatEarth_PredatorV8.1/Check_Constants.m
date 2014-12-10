% Check_Constants.m     Version 8.0 1/23/03
%
% OBJECTIVE: Perform a BELIEVABILITY CHECK of the array called constant
% INPUTS: The array called constant.
% OUTPUTS: Text in the Matlab command window.
%

disp(' '); disp(' ')
disp(' '); disp('BELIEVABILITY CHECK of the array called constant');
string1=['For ',aircraft];
disp(string1); disp(' ')
xx=1:67;
NameScript; % Get constant names and comments.
for i=1:67
	string1=['constant(',num2str(xx(i)),')= ',num2str(constant(i))];
	disp(string1)
	string2=['disp(name',num2str(i),')'];
	eval(string2)
	if eval(['isempty(comment',num2str(i),')'])
	else
		string3=['disp(comment',num2str(i),')'];
		eval(string3)
	end
	if i==46
		SM=-constant(46)/constant(29)*100; % Compute static margin in percent MAC.
		string4=['Static margin= ',num2str(SM),'%MAC. Typically 5 to 50 percent for manned aircraft.'];
		disp(string4)
	end
	disp(' ')
end
