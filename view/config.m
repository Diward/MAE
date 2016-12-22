function varargout = config(varargin)
% CONFIG MATLAB code for config.fig
%      CONFIG, by itself, creates a new CONFIG or raises the existing
%      singleton*.
%
%      H = CONFIG returns the handle to a new CONFIG or the handle to
%      the existing singleton*.
%
%      CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIG.M with the given input arguments.
%
%      CONFIG('Property','Value',...) creates a new CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help config

% Last Modified by GUIDE v2.5 19-Dec-2016 18:56:37

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before config is made visible.
function config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to config (see VARARGIN)

% Choose default command line output for config
handles.output = hObject;
% Update handles structure

guidata(hObject, handles);


% UIWAIT makes config wait for user response (see UIRESUME)
% uiwait(handles.fig_config);


% --- Outputs from this function are returned to the command line.
function varargout = config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function from_hh_Callback(hObject, eventdata, handles)
% hObject    handle to from_hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from_hh as text
%        str2double(get(hObject,'String')) returns contents of from_hh as a double


% --- Executes during object creation, after setting all properties.
function from_hh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from_hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function from_mm_Callback(hObject, eventdata, handles)
% hObject    handle to from_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from_mm as text
%        str2double(get(hObject,'String')) returns contents of from_mm as a double


% --- Executes during object creation, after setting all properties.
function from_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_hh_Callback(hObject, eventdata, handles)
% hObject    handle to to_hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_hh as text
%        str2double(get(hObject,'String')) returns contents of to_hh as a double


% --- Executes during object creation, after setting all properties.
function to_hh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_hh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_mm_Callback(hObject, eventdata, handles)
% hObject    handle to to_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_mm as text
%        str2double(get(hObject,'String')) returns contents of to_mm as a double


% --- Executes during object creation, after setting all properties.
function to_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in ok_btn.
function ok_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ok_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
from_h = str2num(get(handles.from_hh, 'String'));
from_m = str2num(get(handles.from_mm, 'String'));
to_h = str2num(get(handles.to_hh, 'String'));
to_m = str2num(get(handles.to_mm, 'String'));
try
    formatOut = 'yyyy-mm-dd';
    date = datestr(get(handles.from_d,'String'),formatOut);
    date_num = datenum(date);
    if date_num < datenum(datestr(now,formatOut))
        date_ok = 1;
    else
        date_ok = 0;
    end
catch
    date_ok = 0;
end  
if( length([from_h, from_m, to_h, to_m]) == 4 && ...
(0 <= from_h) && (from_h <= 23 ) && (0 <= to_h) && (to_h <= 23) && ...
(0 <= from_m) && (from_m <= 60) && (0 <= to_m) && (to_m <= 60) && date_ok )
    first_fig = findobj('Tag','fig_first');
    first_fig_handles = guidata(first_fig);
    set(first_fig_handles.login_btn, 'Enable', 'on');
    
    from = strcat(get(handles.from_hh, 'String'), ':', get(handles.from_mm, 'String'));
    to = strcat(get(handles.to_hh, 'String'), ':', get(handles.to_mm, 'String'));  
    first_fig_handles.from_h = from;
    first_fig_handles.to_h = to;
    first_fig_handles.from_d = date;
    first_fig_handles.to_d = get(handles.text_today, 'String');
    guidata(first_fig, first_fig_handles);
    
    close(handles.fig_config);      
else 
    set(handles.error_msg, 'String', 'ERROR: Bad hour or date format');
end

% --- Executes during object creation, after setting all properties.
function from_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to from_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_today_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_today (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
formatOut = 'yyyy-mm-dd';
set(hObject, 'String', datestr(now,formatOut));



function from_d_Callback(hObject, eventdata, handles)
% hObject    handle to from_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of from_d as text
%        str2double(get(hObject,'String')) returns contents of from_d as a double
