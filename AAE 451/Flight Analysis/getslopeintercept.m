function [p1,p2,slope,inter]=getslopeintercept
% SYNTAX:
%       [p1,p2,slope,inter]=getslopeintercept
% OUTPUTS:
%       P1= coordinates of the first cliked point
%       P2= coordinates of the second cliked point
%       SLOPE= slope of the drawn line
%       INTER= intercept Y(X=0)
% WHAT ?
%       In the current figure, you have to draw a line between 2 clicked 
%       points of a planar graph. The GETSLOPEINTERCEPT function then
%       displays the slope and the intercept of the drawn line in a text box
% EXAMPLE
%       plot([1:10],[1:10].^0.5,'-o')
%       getslopeintercept

% inspired from RBLINE (Sandra Martinka, March 2002)
% modified (uicontrols, slope, intercept) by jean-luc.dellis@u-picardie.fr,
% June 2006, Mars 2009

% ERRORS
hcurves=findobj('type','line');
if isempty(hcurves), error('There is No Curve !!'), end

% before processing, delete all the old getslopeintercept-objets 
deleteobj([],[])
% prepare and prompt the user to click
oldwbmf=get(gcf,'WindowButtonMotionFcn');   % get current callback to restore it later
oldpointer=get(gcf,'pointer');              % get current pointer shape to restore it later
set(gcf,'pointer','crosshair')              % now change it to show up that getslope is working
pos=[0.01,0.04,0.10,0.03];                  % starting position for the next uicontrols
htext=uicontrol('style','text','units','normalized','backgroundcolor',[1,1,0],...
    'string','Click Twice','position',pos); % prompt to click twice
hold on;
% WAITING FIRST CLICK
waitforbuttonpress;%                        
set(gcf,'WindowButtonMotionFcn','wbmf','DoubleBuffer','on');% now change the motion callback
delete(htext)
p1=get(gca,'CurrentPoint');                 % get starting point
p1=p1(1,1:2);                               % extract x and y
                                            % plot starting point:
lh=line('xdata',p1(1),'ydata',p1(2),'marker','o','color','r','tag','lineofgetslope');
setappdata(gcf,'p1',p1)                     % store the structure in application data
setappdata(gcf,'lh',lh)                     % to be used by the subfunction wbmf
% WAITING SECOND CLICK While wbmf is running
waitforbuttonpress;                         
p2=get(gca,'Currentpoint');                 % get end point
p2=p2(1,1:2);                               % extract x and y
set(gcf,'pointer',oldpointer)               % restore the pointer
set(gcf,'WindowButtonMotionFcn',oldwbmf,'DoubleBuffer','off'); % restore the old callback
dy=p2(1,2)-p1(1,2);                         % compute the slope and process infinity:
if isequal(dy,0),dy=eps;end                 
dx=p2(1,1)-p1(1,1);
if isequal(dx,0),dx=eps;end
slope=dy/dx;
inter=p1(1,2)-slope*p1(1,1);
slopeT=num2str(slope,'%+1.3g');             % place the slope in a text box:
interT=num2str(inter,'%+1.3g');
dx=num2str(dx,'%+1.3g');
dy=num2str(dy,'%+1.3g');
% TEXT BOX
string=['slope: ',slopeT,'  inter: ',interT,'  dx: ',dx,'  dy: ',dy];
postext=(p1+p2)/2;
ht=text(postext(1),postext(2),string,'backgroundcolor',[1,0.8,0.4],'tag','infotext');
extent=get(ht,'extent');                    % control the textbox position in the figure:
postext=get(ht,'position');
if (extent(1)+extent(3))>max(get(gca,'xlim')),set(ht,'position',postext-[(extent(1)+extent(3))-max(get(gca,'xlim')),0,0]),end
if (extent(1)+extent(3))<min(get(gca,'xlim')),set(ht,'position',postext+[(extent(1)+extent(3))-min(get(gca,'xlim')),0,0]),end
% create a CLOSE and a PROCESS AGAIN pushbuttons if they did not exist:
if isempty(findobj(gcf,'tag','closegetslope'))
    uicontrol('style','pushbutton','string','close',...
                'TooltipString','delete line and text','tag','closegetslope',...
                 'units','normalized','position',pos+[0,0.06,0.04,0],... 
                 'callback',@deleteobj);    % close all getslope objects
    uicontrol('style','pushbutton','string','process again',...
                'TooltipString','process again',...
                 'units','normalized','position',pos+[0,0.03,0.04,0],... 
                'callback','[p1,p2,slope,inter]=getslopeintercept');     % call getslope itself
end
%-------------------------------------------------------------------------         
function wbmf                               % window motion callback function to draw the rubber line
p1=getappdata(gcf,'p1');
lh=getappdata(gcf,'lh');
ptemp=get(gca,'CurrentPoint');
ptemp=ptemp(1,1:2);
set(lh,'XData',[p1(1),ptemp(1)],'YData',[p1(2),ptemp(2)]);
drawnow
%-------------------------------------------------------------------------
function deleteobj(no_use1,no_use2)         % this uicontrol callback does Not Use inputs
                                            % when 2 arguments are required
                                            % when called by function handle
delete(findobj(gca,'tag','lineofgetslope'))
delete(findobj(gca,'tag','infotext'));
delete(findobj(gcf,'string','process again'))
delete(findobj(gcf,'string','close'))



