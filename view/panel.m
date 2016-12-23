function varargout = panel(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panel_OpeningFcn, ...
                   'gui_OutputFcn',  @panel_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function panel_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.date = varargin{1,1}.date;
handles.hour = varargin{1,1}.hour;
handles.login_btn = varargin{1,1}.login_btn;
guidata(hObject, handles);
init(hObject);
set(hObject, 'Name', strjoin(strcat('Day:',{' '},handles.date,{' '},'Hour:',{' '},handles.hour)));


function varargout = panel_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function fig_panel_CloseRequestFcn(hObject, eventdata, handles)
set(handles.login_btn, 'Enable', 'on');
delete(hObject);

function init(hObject)
handles = guidata(hObject);
[ steps, kcal, hr, floors ] = get_data(handles.date,handles.hour);
init_kcal(hObject, kcal);
init_floors(hObject, floors);
init_steps_axes(hObject, steps);
init_hr_axes(hObject, hr);
update_alarms(hObject);

function init_steps_axes(hObject, s)
handles = guidata(hObject);
try
    data = cell2mat(s.activities_0x2D_steps_0x2D_intraday.dataset);
    succes = true;
catch
    succes = false;
end
if (succes)
    y = cell2mat({data(:).value});
    handles = guidata(hObject);
    handles.dataset_steps = data;
    guidata(hObject, handles);
    if (max(y) == 0)
        bar(y, 'Parent', handles.step_axes);grid on;
    else
        bar(y, 'Parent', handles.step_axes);grid on;
        set(handles.step_slider, 'Value', 0);
        set(handles.step_zoom, 'Value', 0);
        handles.step_axes.XTickLabelRotation = 60;
        set(handles.step_axes,'ylim',[0,max(y)]);
        update_steps_zoom(handles);
        set(handles.step_text,'ForegroundColor','black');
        set(handles.step_panel, 'Title', 'Steps'); 
        set(handles.step_text,'String',s.activities_0x2D_steps{1}.value);
        set(handles.error_step_panel, 'Visible', 'off');
    end
else
    set(handles.step_panel, 'Visible', 'off');
    set(handles.error_step_panel, 'Title', 'Petition ERROR');
    set(handles.error_step_text,'String',s.errors{1, 1}.message);
end

function init_hr_axes(hObject, hr)
handles = guidata(hObject);
try
    data = cell2mat(hr.activities_0x2D_heart_0x2D_intraday.dataset);
    succes = true;
catch
    succes = false;
end
if (succes)
    y = cell2mat({data(:).value});
    x = {data(:).time};
    plot(y, 'Parent', handles.hr_axes);grid on;
    handles.hr_axes.XTickLabelRotation = 60;
    set(handles.hr_axes,'ylim',[0,max(y)]);
    set(handles.hr_axes,'xlim',[0,length(x)]);
    xaxis = 0:length(x)/4:length(x);
    set(handles.hr_axes,'xtick',xaxis);
    xaxislabel = cell(1,length(xaxis));
    xaxis(1) = xaxis(1)+1;
    for i=1:length(xaxis)
       xaxislabel{i} = datestr(x{ceil(xaxis(i))},'HH:MM');
    end
    set(handles.hr_axes,'XTickLabel',xaxislabel);
    set(handles.step_text,'ForegroundColor','black');
    set(handles.hr_panel, 'Title', 'Heart Rate mean'); 
    set(handles.hr_text,'String',mean(y));
    set(handles.error_hr_panel, 'Visible', 'off');
else
    set(handles.hr_panel, 'Visible', 'off');
    set(handles.error_hr_panel, 'Title', 'Peition ERROR');
    set(handles.error_hr_text,'String',hr.errors{1, 1}.message);
    disp(hr.errors{1, 1}.message);
end

function init_kcal(hObject, kcal)
handles = guidata(hObject);
try
    total_kcal = kcal.activities_0x2D_calories{1, 1}.value;
    succes = true;
catch
    succes = false;
end
if (succes)
    set(handles.kcal_panel, 'Title', 'Total KCAL burned'); 
    set(handles.kcal_text,'ForegroundColor','black');
    set(handles.kcal_text,'FontSize',15);
    set(handles.kcal_text,'HorizontalAlignment','center');
    set(handles.kcal_text,'String',strcat(total_kcal,{' '},'Kcal'));
else
    set(handles.kcal_panel, 'Title', 'Peition ERROR');
    set(handles.kcal_text,'ForegroundColor','red');
    set(handles.kcal_text,'String',kcal.errors{1, 1}.message);
    disp(kcal.errors{1, 1}.message);
end

function init_floors(hObject, floors)
handles = guidata(hObject);
try
    total_floors = floors.activities_0x2D_floors{1, 1}.value;
    succes = true;
catch
    succes = false;
end
if (succes)
    set(handles.floors_panel, 'Title', 'Total FLOORS climbed'); 
    set(handles.floors_text,'ForegroundColor','black');
    set(handles.floors_text,'FontSize',15);
    set(handles.floors_text,'HorizontalAlignment','center');
    set(handles.floors_text,'String',strcat(total_floors,{' '},'Floors'));
else
    set(handles.floors_panel, 'Title', 'Peition ERROR');
    set(handles.floors_text,'ForegroundColor','red');
    set(handles.floors_text,'String',floors.errors{1, 1}.message);
    disp(floors.errors{1, 1}.message);
end

function step_slider_Callback(hObject, eventdata, handles)
update_steps_zoom(handles);

function step_zoom_Callback(hObject, eventdata, handles)
update_steps_zoom(handles);

function update_steps_zoom(handles)
step_slider = get(handles.step_slider,'Value');
step_zoom = 1-get(handles.step_zoom,'Value');
L = length(handles.dataset_steps);
min_window = 5;
w = (L - min_window)*step_zoom + min_window;
c = (L - w)*step_slider + w/2;
set(handles.step_axes,'xlim',[c-w/2,c+w/2]);
xaxis = c-w/2:w/4:c+w/2;
set(handles.step_axes,'xtick',xaxis);
x = {handles.dataset_steps(:).time};
xaxislabel = cell(1,length(xaxis));
xaxis(1) = xaxis(1)+1;
for i=1:length(xaxis)
   xaxislabel{i} = datestr(x{ceil(xaxis(i))},'HH:MM');
end
set(handles.step_axes,'XTickLabel',xaxislabel);
if (step_zoom == 1)
   set(handles.step_slider,'Enable', 'off');
else
   set(handles.step_slider,'Enable', 'on');
end

function update_alarms(hObject)
handles = guidata(hObject);
list = {''};
alarms = get_alarms();
try
    alarms = cell2mat(alarms.trackerAlarms);
    list = {alarms(:).time};
    handles.alarms = alarms;
    guidata(hObject, handles);
    set(handles.alarm_list,'String', list);
    set(handles.delete_alarm_but, 'Enable', 'on')
catch
    set(handles.alarm_list,'String', list);
    set(handles.delete_alarm_but, 'Enable', 'off')
end

function delete_alarm_but_Callback(hObject, eventdata, handles)
pos = get(handles.alarm_list, 'Value');
alarm_to_delete = handles.alarms(pos).alarmId;
delete_alarm(alarm_to_delete);
list_box = get(handles.alarm_list, 'String');
list_box{pos} = '';
list_box = list_box(~cellfun('isempty',list_box));
if (isempty(list_box))
    set(handles.delete_alarm_but, 'Enable', 'off');
end
set(handles.alarm_list,'String', list_box);

function create_alarm_button_Callback(hObject, eventdata, handles)
b = findobj(gcf);
c = findall(b,'Style','checkbox','-and','Value', 1);
days = unique(get(c, 'String'));
days_check = true;
hour_check = true;
if (isempty(days))
    set(handles.days_panel,'ForegroundColor', 'red');
    days_check = false;
else
    days = strjoin(days,',');
end
hour = get(handles.alarm_hour,'String');
min = get(handles.alarm_min,'String');
if ( str2double(hour) < 0 || str2double(hour) > 23 ||str2double(min) < 0 ||...
str2double(min) > 59 || strcmp(hour,'') ||  strcmp(min,''))
    set(handles.hour_panel,'ForegroundColor', 'red');
    hour_check = false;
end
if ( days_check && hour_check )
    set(handles.hour_panel,'ForegroundColor', 'black');
    set(handles.days_panel,'ForegroundColor', 'black');
    h = mod(str2double(hour)-1, 24);
    hour_to_send = strcat(num2str(h),':',min,'-','00:00');
    add_alarm(hour_to_send, days)
    update_alarms(hObject);
end

% DEFAULT CREATE FUNCTIONS
function alarm_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alarm_min_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alarm_hour_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function step_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function step_zoom_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
