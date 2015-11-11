function varargout = test_launcher(varargin)
% TEST_LAUNCHER MATLAB code for test_launcher.fig
%      TEST_LAUNCHER, by itself, creates a new TEST_LAUNCHER or raises the existing
%      singleton*.
%
%      H = TEST_LAUNCHER returns the handle to a new TEST_LAUNCHER or the handle to
%      the existing singleton*.
%
%      TEST_LAUNCHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_LAUNCHER.M with the given input arguments.
%
%      TEST_LAUNCHER('Property','Value',...) creates a new TEST_LAUNCHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_launcher_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_launcher_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_launcher

% Last Modified by GUIDE v2.5 09-Nov-2015 13:25:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_launcher_OpeningFcn, ...
                   'gui_OutputFcn',  @test_launcher_OutputFcn, ...
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


% --- Executes just before test_launcher is made visible.
function test_launcher_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_launcher (see VARARGIN)

% Choose default command line output for test_launcher
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_launcher wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_launcher_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dataParameters = struct('name',{},'path',{});
% DataDir=dir('src/test/testdata/*_*');
% pathname = [];
% filename = [];
% for i = 1:length(pathname)
%     pathname = [pathname; cellstr(getfield(DataDir,{i},'name'))];
%     filename = [filename; 'Name']
% end

A=dir('src/test/testdata/*_*');
value = [];
for i = 1:length(A)

    value = [value; cellstr(getfield(A,{i},'name'))];

end

for i = 1:length(value)
    %value(i)
    dataObj.name = value(i);
    dataObj.path = horzcat('src/test/testdata/',char(value(i)),'/');
    dataObj.path;
    dataParameters{i} = dataObj;
    
end

% 2. Create models when user selects them:
modelParameters = struct( ...
    'tabu', struct('active',0,'initial',1,'phases',[1]), ...
    'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
    'ampl', struct('active',0,'initial',1,'phases',[1]));

input = get(handles.edit1,'String');
input = str2num(input)

global cb
if (get(handles.pushbutton1,'Value'))==1
     if cb==1
          modelParameters.tabu = setfield(modelParameters.tabu,'active',1);
          modelParameters.tabu = setfield(modelParameters.tabu,'phases',input);
     elseif cb==2
          modelParameters.LNS = setfield(modelParameters.LNS,'active',1);
          modelParameters.LNS = setfield(modelParameters.LNS,'phases',input);
     elseif cb==3
          modelParameters.ampl = setfield(modelParameters.ampl,'active',1);
          modelParameters.ampl = setfield(modelParameters.ampl,'phases',input);
     end
end

% 3. run launcher
status = mainlauncher(dataParameters, modelParameters);

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

global cb
if get(handles.checkbox1,'Value')==1
     cb=1; 
end

% modelParameters = struct( ...
%     'tabu', struct('active',0,'initial',1,'phases',[1]), ...
%     'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
%     'ampl', struct('active',0,'initial',1,'phases',[1]));
% modelParameters.tabu = setfield(modelParameters.tabu,'active',1);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

global cb
if get(handles.checkbox1,'Value')==1
     cb=2; 
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

global cb
if get(handles.checkbox1,'Value')==1
     cb=3; 
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

A=dir('src/test/testdata/*_*');
value = [];
for i = 1:length(A)

    value = [value; cellstr(getfield(A,{i},'name'))];

end

set(hObject,'String',value);
