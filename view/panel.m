function varargout = panel(varargin)
% PANEL MATLAB code for panel.fig
%      PANEL, by itself, creates a new PANEL or raises the existing
%      singleton*.
%
%      H = PANEL returns the handle to a new PANEL or the handle to
%      the existing singleton*.
%
%      PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL.M with the given input arguments.
%
%      PANEL('Property','Value',...) creates a new PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panel

% Last Modified by GUIDE v2.5 22-Dec-2016 00:59:30

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before panel is made visible.
function panel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panel (see VARARGIN)

% Choose default command line output for panel
handles.output = hObject;

first_fig = findobj('Tag','fig_first');
first_fig_handles = guidata(first_fig);
handles.login_btn = first_fig_handles.login_btn;
handles.from_d = first_fig_handles.from_d;
handles.to_d = first_fig_handles.to_d;
handles.from_h = first_fig_handles.from_h;
handles.to_h = first_fig_handles.to_h;
% Update handles structure
guidata(hObject, handles);
init(hObject, handles);

% UIWAIT makes panel wait for user response (see UIRESUME)
% uiwait(handles.fig_panel);


% --- Outputs from this function are returned to the command line.
function varargout = panel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close fig_panel.
function fig_panel_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
set(handles.login_btn, 'Enable', 'on');
delete(hObject);

function init(hObject, handles)
[ steps, kcal, hr, floors ] = get_data(handles.from_d, handles.to_d,handles.from_h,handles.to_h);
init_steps_axes(hObject, handles, steps);
init_hr_axes(handles, hr);
init_kcal(handles, kcal);
init_floors(handles, floors);

function init_steps_axes(hObject, handles, s)
try
    data = cell2mat(s.activities_0x2D_steps_0x2D_intraday.dataset);
    succes = true;
catch
    succes = false;
end
if (succes)
    y = cell2mat({data(:).value});
    handles.step_dataset = data;
    guidata(hObject, handles);
    newplot();
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
else
    set(handles.step_panel, 'Visible', 'off');
    set(handles.error_step_panel, 'Title', 'Petition ERROR');
    set(handles.error_step_text,'String',s.errors{1, 1}.message);
end

function update_steps_zoom(handles)
step_slider = get(handles.step_slider,'Value');
step_zoom = 1-get(handles.step_zoom,'Value');
L = length(handles.step_dataset);
min_window = 5;
w = (L - min_window)*step_zoom + min_window;
c = (L - w)*step_slider + w/2;
set(handles.step_axes,'xlim',[c-w/2,c+w/2]);
xaxis = c-w/2:w/4:c+w/2;
set(handles.step_axes,'xtick',xaxis);
x = {handles.step_dataset(:).time};
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

function init_hr_axes(handles, hr)
try
    data = cell2mat(hr.activities_0x2D_heart_0x2D_intraday.dataset);
    succes = true;
catch
    succes = false;
end
if (succes)
    y = cell2mat({data(:).value});
    x = {data(:).time};
    newplot();
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
    set(handles.hr_text,'String',hr.activities_0x2D_heart{1, 1}.value);
    set(handles.error_hr_panel, 'Visible', 'off');
else
    set(handles.hr_panel, 'Visible', 'off');
    set(handles.error_hr_panel, 'Title', 'Peition ERROR');
    set(handles.error_hr_text,'String',hr.errors{1, 1}.message);
    disp(hr.errors{1, 1}.message);
end

function init_kcal(handles, kcal)
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

function init_floors(handles, floors)
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



% --- Executes on slider movement.
function step_slider_Callback(hObject, eventdata, handles)
% hObject    handle to step_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_steps_zoom(handles);

% --- Executes during object creation, after setting all properties.
function step_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function step_zoom_Callback(hObject, eventdata, handles)
% hObject    handle to step_zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_steps_zoom(handles);

% --- Executes during object creation, after setting all properties.
function step_zoom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in alarm_list.
function alarm_list_Callback(hObject, eventdata, handles)
% hObject    handle to alarm_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alarm_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alarm_list


% --- Executes during object creation, after setting all properties.
function alarm_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alarm_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
update_alarms(hObject, handles);

function update_alarms(hObject, handles)
alarms = get_alarms();
try
    alarms = cell2mat(alarms.trackerAlarms);
    list = {alarms(:).time};
    handles.alarms = alarms;
    guidata(hObject, handles);
    set(handles.alarm_list,'String', list);
catch
    set(alarm_list,'String', 'NO ALARMS');
end


% --- Executes on button press in delete_alarm_but.
function delete_alarm_but_Callback(hObject, eventdata, handles)
% hObject    handle to delete_alarm_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos = get(handles.alarm_list, 'Value');
handles.alarms
alarm_to_delete = handles.alarms(pos).alarmId;
delete_alarm(alarm_to_delete);
list_box = get(handles.alarm_list, 'String');
list_box{pos} = '';
set(handles.alarm_list,'String', list_box);



function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double


% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hour_Callback(hObject, eventdata, handles)
% hObject    handle to hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hour as text
%        str2double(get(hObject,'String')) returns contents of hour as a double


% --- Executes during object creation, after setting all properties.
function hour_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in create_alarm_button.
function create_alarm_button_Callback(hObject, eventdata, handles)
% hObject    handle to create_alarm_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b = findobj(gcf);
c = findall(b,'Style','checkbox','-and','Value', 1);
days = unique(get(c, 'String'));
days_check = true;
hour_check = true;
if (isempty(days))
    set(handles.days_panel,'ForegroundColor', 'red');
    days_check = false;
end
days = strjoin(days,',')
hour = get(handles.hour,'String');
min = get(handles.min,'String');
if ( str2double(hour) < 0 || str2double(hour) > 23 ||str2double(min) < 0 || str2double(min) > 59)
    set(handles.hour_panel,'ForegroundColor', 'red');
    hour_check = false;
end
if ( days_check && hour_check )
    set(handles.hour_panel,'ForegroundColor', 'black');
    set(handles.days_panel,'ForegroundColor', 'black');
    m = str2double(min)+1;
    hour_to_send = strcat(hour,':',min,'-',datestr(strcat(hour,':',num2str(m)), 'HH:MM'));
    add_alarm(hour_to_send, days)
    update_alarms(hObject, handles);
end


% --- Executes on button press in monday.
function monday_Callback(hObject, eventdata, handles)
% hObject    handle to monday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of monday


% --- Executes on button press in tuesday.
function tuesday_Callback(hObject, eventdata, handles)
% hObject    handle to tuesday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tuesday


% --- Executes on button press in wednesday.
function wednesday_Callback(hObject, eventdata, handles)
% hObject    handle to wednesday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wednesday


% --- Executes on button press in thursday.
function thursday_Callback(hObject, eventdata, handles)
% hObject    handle to thursday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of thursday


% --- Executes on button press in friday.
function friday_Callback(hObject, eventdata, handles)
% hObject    handle to friday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of friday


% --- Executes on button press in saturday.
function saturday_Callback(hObject, eventdata, handles)
% hObject    handle to saturday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saturday


% --- Executes on button press in sunday.
function sunday_Callback(hObject, eventdata, handles)
% hObject    handle to sunday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sunday
