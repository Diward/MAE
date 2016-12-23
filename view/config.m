
function varargout = config(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @config_OpeningFcn, ...
                   'gui_OutputFcn',  @config_OutputFcn, ...
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

function config_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
init(handles);
guidata(hObject, handles);


function varargout = config_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function init(handles)
set(handles.hour_error_panel, 'Visible', 'off');
set(handles.date_error_panel, 'Visible', 'off');

function from_d_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function day_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function month_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function year_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function from_hh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function from_mm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function to_hh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function to_mm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [ date, res ] = check_date(handles)
if (get(handles.today_check, 'Value') == 1)
    date = datestr(datetime('today'),'yyyy-mm-dd');
    res = true;
    return;
else
    day = get(handles.day,'String');
    month = get(handles.month,'String');
    year = get(handles.year,'String');
    date = strcat(year,'-',month,'-',day);
    try
        date = datestr(date,'yyyy-mm-dd');
        date_num = datenum(date);
        if date_num < datenum(datetime('today'))
            res =  true;
            return;
        end
    end
end
res = false;

function [ hour, res ] = check_hour(handles)
from_h = str2double(get(handles.from_hh, 'String'));
from_m = str2double(get(handles.from_mm, 'String'));
to_h = str2double(get(handles.to_hh, 'String'));
to_m = str2double(get(handles.to_mm, 'String'));
if( length([from_h, from_m, to_h, to_m]) == 4 && ...
(0 <= from_h) && (from_h <= 23 ) && (0 <= to_h) && (to_h <= 23) && ...
(0 <= from_m) && (from_m <= 60) && (0 <= to_m) && (to_m <= 60) && ...
from_h+from_m < to_h+to_m)
    from = strcat(get(handles.from_hh, 'String'), ':', get(handles.from_mm, 'String'));
    to = strcat(get(handles.to_hh, 'String'), ':', get(handles.to_mm, 'String'));  
    hour = strcat(from,'/',to);
    res = true;
else 
    res = false;
    hour = '';
end
 
function ok_btn_Callback(hObject, eventdata, handles)
[date, date_ok] = check_date(handles);
[hour, hour_ok] = check_hour(handles);
handles.date = date;
handles.hour = hour;
guidata(hObject, handles);
if (~date_ok)
   set(handles.date_error_panel, 'Visible', 'on');
   set(handles.date_error_msg, 'String', 'Bad date');
else
    set(handles.date_error_panel, 'Visible', 'off');
end
if (~hour_ok)
   set(handles.hour_error_panel, 'Visible', 'on');
   set(handles.hour_error_msg, 'String', 'Bad hour format');
else
    set(handles.hour_error_panel, 'Visible', 'off');
end
if (date_ok && hour_ok)
    first_fig = findobj('Tag','fig_first');
    first_fig_handles = guidata(first_fig);
    set(first_fig_handles.login_btn, 'Enable', 'on');
    first_fig_handles.date = date;
    first_fig_handles.hour = hour;
    guidata(first_fig, first_fig_handles);
    close(handles.fig_config);      
end

function today_check_Callback(hObject, eventdata, handles)
val = get(hObject, 'Value');
if(val)
    enabled = 'off';
else
    enabled = 'on';
end
set(handles.day, 'Enable', enabled, 'String', '');
set(handles.month, 'Enable',enabled,'String', '');
set(handles.year, 'Enable', enabled,'String', '');

