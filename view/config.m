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

% Last Modified by GUIDE v2.5 18-Dec-2016 21:57:21

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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Today';'This week';'This month'},'Value',1);



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

if( length([from_h, from_m, to_h, to_m]) == 4 && ...
(0 <= from_h) && (from_h <= 23 ) && (0 <= to_h) && (to_h <= 23) && ...
(0 <= from_m) && (from_m <= 60) && (0 <= to_m) && (to_m <= 60) )
    set(handles.error_msg, 'String', get(handles.popupmenu1, 'Value'));
     
    first_fig = findobj('Tag','fig_first');
    first_fig_handles = guidata(first_fig);
    set(first_fig_handles.login_btn, 'Enable', 'on');
    
    from = strcat(get(handles.from_hh, 'String'), ':', get(handles.from_mm, 'String'));
    to = strcat(get(handles.to_hh, 'String'), ':', get(handles.to_mm, 'String'));  
    first_fig_handles.from = from;
    first_fig_handles.to = to;
    first_fig_handles.period = get(handles.popupmenu1, 'Value');
    guidata(first_fig, first_fig_handles);
    
    close(handles.fig_config);
else 
    set(handles.error_msg, 'String', 'ERROR: Bad hour format');
end

%function init(handles)