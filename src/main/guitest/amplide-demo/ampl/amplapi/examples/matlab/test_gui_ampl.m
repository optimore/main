function varargout = test_gui_ampl(varargin)
% TEST_GUI_AMPL MATLAB code for test_gui_ampl.fig
%      TEST_GUI_AMPL, by itself, creates a new TEST_GUI_AMPL or raises the existing
%      singleton*.
%
%      H = TEST_GUI_AMPL returns the handle to a new TEST_GUI_AMPL or the handle to
%      the existing singleton*.
%
%      TEST_GUI_AMPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_GUI_AMPL.M with the given input arguments.
%
%      TEST_GUI_AMPL('Property','Value',...) creates a new TEST_GUI_AMPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_gui_ampl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_gui_ampl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_gui_ampl

% Last Modified by GUIDE v2.5 03-Nov-2015 11:38:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_gui_ampl_OpeningFcn, ...
                   'gui_OutputFcn',  @test_gui_ampl_OutputFcn, ...
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


% --- Executes just before test_gui_ampl is made visible.
function test_gui_ampl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_gui_ampl (see VARARGIN)

% Choose default command line output for test_gui_ampl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_gui_ampl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_gui_ampl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




setupOnce

res = efficientFrontier;

i = length(res);

x = [];
y = [];
posx = [];
posy = [];
for k = 1:i
    if res(k)<0.01
       x = [x res(k)]; 
       posx = [posx k];
    else
        y = [y res(k)];
        posy = [posy k];
    end
end
        
axes(handles.axes2)
hold on
plot(posx,x,'o')
plot(posy,y,'x')        
        
function Result_Ans_Callback(hObject, eventdata, handles)
% hObject    handle to Result_Ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Result_Ans as text
%        str2double(get(hObject,'String')) returns contents of Result_Ans as a double


% --- Executes during object creation, after setting all properties.
function Result_Ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Result_Ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result as text
%        str2double(get(hObject,'String')) returns contents of result as a double


% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

res = efficientFrontier;
save temp_res.dat res -ascii
