function varargout = first(varargin)
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

function first_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
init(handles);
guidata(hObject, handles);

function varargout = first_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function init(handles)
set(handles.login_btn, 'Enable', 'off');

function instructions_text_CreateFcn(hObject, eventdata, handles)
s1 = '1.- First of all click on config button in order to set DAY and HOUR settings.';
s2 = ['2.- After that, click on Login button to open the panel view. '...
      'Web browser will apper in order to login with a fitbit account and accept.' ...
      'the permisions, to share data with the application.'];
s3 = ['3.- Finally, the browser will close automatically and you will acces '...
      'to the application planel.'];
s4 = strcat(char(169), ' Created by Eduardo de Prado.');
s5 = 'MAE AUTUM 2016';
s6 = 'Version 1.0';
s = sprintf('%s\n\n%s\n\n%s\n\n%s\n%s\n%s', s1, s2, s3, s4, s5, s6);
set(hObject,'String',s);

function login_btn_Callback(hObject, eventdata, handles)
obtain_token;
set(handles.login_btn, 'Enable', 'off');
handles.fig_panel = panel(handles);
guidata(hObject, handles);

function conf_btn_Callback(hObject, eventdata, handles)
handles.fig_config = config;
guidata(hObject, handles);

function fig_first_CloseRequestFcn(hObject, eventdata, handles)
if(isfield(handles,'fig_config') && ishandle(handles.fig_config))
    delete(handles.fig_config);
end
if(isfield(handles,'fig_panel') && ishandle(handles.fig_panel))
    delete(handles.fig_panel);
end
delete(hObject);
