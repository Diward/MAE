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

% Last Modified by GUIDE v2.5 20-Dec-2016 18:27:26

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
init_steps(hObject, handles);

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

function init_steps(hObject, handles)
from_d = handles.from_d;
to_d = handles.to_d;
from_h= handles.from_h;
to_h= handles.to_h;
[s,d,error] = get_steps(from_d, to_d,from_h,to_h);
handles.len = length(d);
guidata(hObject, handles);
if (error.success)
    newplot();
    bar(s, 'Parent', handles.step_axes);grid on;
    set(handles.step_axes,'XTickLabel',d);
    set(handles.step_slider, 'Value', 0);
    update_steps_zoom(handles);
else 
    set(handles.step_text,'ForegroundColor','red');
    set(handles.step_text, 'String', error.errors{1, 1}.message);
end

function update_steps_zoom(handles)
step_slider = get(handles.step_slider,'Value');
w = 7;
c = (handles.len - w)*step_slider + w/2;
set(handles.step_axes,'xlim',[c-w/2,c+w/2]);


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
