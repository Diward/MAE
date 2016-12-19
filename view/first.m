function varargout = first(varargin)
% FIRST MATLAB code for first.fig
%      FIRST, by itself, creates a new FIRST or raises the existing
%      singleton*.
%
%      H = FIRST returns the handle to a new FIRST or the handle to
%      the existing singleton*.
%
%      FIRST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRST.M with the given input arguments.
%
%      FIRST('Property','Value',...) creates a new FIRST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before first_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to first_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help first

% Last Modified by GUIDE v2.5 18-Dec-2016 23:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_OpeningFcn, ...
                   'gui_OutputFcn',  @first_OutputFcn, ...
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

% --- Executes just before first is made visible.
function first_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to first (see VARARGIN)

% Choose default command line output for first
handles.output = hObject;
init(handles);
handles.period = '';
handles.from = '';
handles.to = '';
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = first_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function init(handles)
set(handles.login_btn, 'Enable', 'off');

function instructions_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to instructions_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
s1 = ['1.- Clicking on Login button a web browser will be opened '...
      'for you to log with your fitbit account. Before doing that, you '...
      'have to set the options on CONFIGURATION panel.'];
s2 = ['2.- You will be redirected to a new window after the login, where it '...
      'will ask you for the permissions of the app. Just mark all the checks ' ...
      'to allow the app acces all the data.'];
s3 = ['3.- After that, the browser will be automatically closed and you will acces '...
      'to the application. If the fitbit session is active the point 1 and 2 are ' ...
      'already done, so the browser will just be opened for a few seconds and closed '...
      'by itself.'];
s4 = strcat(char(169), ' Created by Eduardo de Prado.');
s5 = 'MAE AUTUM 2016';
s6 = 'Version 0.1';
s = sprintf('%s\n\n%s\n\n%s\n\n%s\n%s\n%s', s1, s2, s3, s4, s5, s6);
set(hObject,'String',s);

% --- Executes on button press in login_btn.
function login_btn_Callback(hObject, eventdata, handles)
% hObject    handle to login_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
obtain_token;
%%% set(handles.login_btn, 'Enable', 'off');
if ( handles.period == 1 )
    set(handles.login_btn, 'Enable', 'off');
    handles.fig_today = today;
else
    disp('week or month')
end

% --- Executes on button press in conf_btn.
function conf_btn_Callback(hObject, eventdata, handles)
% hObject    handle to conf_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fig_config = config;
guidata(hObject, handles);

% --- Executes when user attempts to close fig_first.
function fig_first_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isfield(handles,'fig_config') && ishandle(handles.fig_config))
    delete(handles.fig_config);
end
delete(hObject);
