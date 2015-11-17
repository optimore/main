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

% Last Modified by GUIDE v2.5 13-Nov-2015 14:38:06

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

global run_cb
global index_listbox2

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



% 2. Create models when user selects them:
modelParameters = struct( ...
    'tabu', struct('active',0,'initial',1,'phases',[1]), ...
    'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
    'ampl', struct('active',0,'initial',1,'phases',[1]));

input = get(handles.edit1,'String');
input = str2num(input)

global cb
if (get(handles.pushbutton1,'Value'))==1
if run_cb==2
    for i = 1:length(value)
        dataObj.name = value(i);
        dataObj.path = horzcat('src/test/testdata/',char(value(i)),'/');
        dataObj.path;
        dataParameters{i} = dataObj;
    end
    
elseif run_cb==1
    for k = 1:length(index_listbox2)
    dataObj.name = value(index_listbox2(k));
    dataObj.path = horzcat('src/test/testdata/',char(value(index_listbox2(k))),'/');
    dataObj.path;
    dataParameters{k} = dataObj;
    end
end

     if cb==1
          modelParameters.tabu = setfield(modelParameters.tabu,'active',1);
          modelParameters.tabu = setfield(modelParameters.tabu,'phases',input);
     elseif cb==2
%           modelParameters.LNS = setfield(modelParameters.LNS,'active',1);
%           modelParameters.LNS = setfield(modelParameters.LNS,'phases',input);
            
            fin = fopen('LNSModel.run','rt');
            fout = fopen('LNSModel_clone.run','wt');
            while ~feof(fin)
                   s = fgets(fin);
                   s = strrep(s, '***FILE1***', 'A0-data');
                   fprintf(fout,'%s\n',s);
            end
            fclose(fin);
            fclose(fout);

     elseif cb==3
          modelParameters.ampl = setfield(modelParameters.ampl,'active',1);
          modelParameters.ampl = setfield(modelParameters.ampl,'phases',input);
     end
end

% 3. run launcher
close_msgbox1 = msgbox('Wait')

status = mainlauncher(dataParameters, modelParameters);
delete(close_msgbox1);

msgbox('Finished')





%LNSmain(dataParameters)
%system('ÄNDRA STRÄNGAR I FILEN')
%system('module add cplex/12.5-fullampl; ampl < LNSModel.run')






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

global index_listbox2


index_listbox2 = get(handles.listbox2,'Value');

%--------------------------------------------------------------------------
% HÄMTA INFORMATION FRÅN LISTAN VIA CALLBACK.
% FYLL LISTBOX FRÅN CREATFCN.
%--------------------------------------------------------------------------


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

global test_data_value

A=dir('src/test/testdata/*_*');
test_data_value = [];
for i = 1:length(A)

    test_data_value = [test_data_value; cellstr(getfield(A,{i},'name'))];

end

set(hObject,'String',test_data_value);


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3

global index_listbox3


index_listbox3 = get(handles.listbox3,'Value');


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

p = B(end);
l = p.name;
temp_1=strcat('target/results/',l);
temp_2=strcat(temp_1,'/*_*');

new_path = dir(temp_2);

past_value=[];
for i = 1:length(new_path)

    past_value = [past_value; cellstr(getfield(new_path,{i},'name'))];

end
set(hObject,'String',past_value);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global new_value

global l

global index_listbox3

global load_data

 if (get(handles.pushbutton3,'Value'))==1
    for k = 1:length(index_listbox3)
    temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_value(index_listbox3(k)));
    temp_path = sprintf('%s',temp_2{:});
    load_data = load(temp_path);
    axes(handles.axes3)
    for p = 1:length(load_data(1:end-1,2))
        ln_data(p)=log(load_data(p,2));
    end
    plot(load_data(1:end-1,3),ln_data(:));
    legend('Objective Fcn / Time')
    end
 end

% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global new_value

global l

if (get(handles.pushbutton4,'Value'))==1

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

p = B(end);
l = p.name;
temp_1=strcat('target/results/',l);
temp_2=strcat(temp_1,'/*_*');

new_path = dir(temp_2);

new_value=[];
for i = 1:length(new_path)

    new_value = [new_value; cellstr(getfield(new_path,{i},'name'))];

end
end

get(handles.listbox3,'Value');
set(handles.listbox3,'String',new_value);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global new_value

global test_data_value

global l

new_value_name = new_value;

for new_val_it = 1:length(new_value)
    new_value_temp_1 = strrep(new_value(new_val_it),'result_',' ');
    
    temp_number =  strrep(new_value_temp_1,num2str(new_val_it),' ');
    
    new_value_temp_2 = strrep(temp_number,'_',' ');
    new_value_name(new_val_it) = new_value_temp_2;

end
 
for iter_1 = 1:length(new_value)
    
    temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_value(iter_1));
    temp_path = sprintf('%s',temp_2{:});
    
    temp_load = load(temp_path);
    
    max_iter(iter_1) = temp_load(end,1);
    
    max_cost(iter_1) = temp_load(end,2);
    
    max_time(iter_1) = temp_load(end,3);
   
end

oldData=[];

for iter_2 = 1:length(new_value)
    
    data_table= [test_data_value(iter_2),new_value_name(iter_2),max_iter(iter_2),max_cost(iter_2),max_time(iter_2)];
    oldData = [oldData;data_table];
    
end

set(handles.uitable1,'data',oldData);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global new_value

global l

global index_listbox3

global load_data

if (get(handles.pushbutton6,'Value'))==1
    for k = 1:length(index_listbox3)
    temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_value(index_listbox3(k)));
    temp_path = sprintf('%s',temp_2{:});
    load_data = load(temp_path);
    axes(handles.axes4)
     for p = 1:length(load_data(1:end-1,2))
        ln_data(p)=log(load_data(p,2));
    end
    plot(load_data(1:end-1,1),ln_data(:));
    legend('Objective Function / Iterations');
    end
end

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10

global run_cb
if get(handles.checkbox10,'Value')==1
     run_cb=1; 
end

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11
global run_cb
if get(handles.checkbox11,'Value')==1
     run_cb=2; 
end
