% Här måste vi kunna läsa/skriva testdata ifrån en fil.
function GUI

close all;

TimelineSolution = [];
attributes = [];
DependencyMatrix = [];
DependencyAttribute = [];
TimelineSolution_mater = [];
attributes_mater = [];
DependencyMatrix_mater = [];
DependencyAttribute_mater = [];

% testdataiterator = ones(3,1);
testdataiterator = 1;

% Antal tasks
N = 100;

% Antal tidssteg
L = 100000000;

% Antal tidslinjer
T = 10;

% Antal data att skapa
Num_data = 1;

% Antal dependencies
Ndeps=20;

% Hur stor del av tidlinjerna som är besatta
occupancy = 0.5;

% Funktionsdefinitioner

genlistoflen = @(listofstartingpoints,L) generatelistoflength(listofstartingpoints,L);
genlistoflst = @(L, N, occupancy) genlistoflengths_startpts(L, N, occupancy);
genlistofstartpts = @(L, N) generatelistofstartingpoints(L, N);
gentasks = @( Ntasks, Ntimelines ) generateNumberoftasksinTimelinevector( Ntasks, Ntimelines );
attrgen_unif = @(TimelineSolution,L,variance,mu) Attributegenerator_uniform(TimelineSolution,L,variance,mu);
attrgen_norm = @(TimelineSolution,L,variance,mu) Attributegenerator_norm(TimelineSolution,L,variance,mu);
gendepmatrix = @(TimelineSolution, Ndependencies, variance, mu) Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu);
gendepattr = @(TimelineSolution,DependencyMatrix, variance, mu, L, N, T) Generatedependencyattributes(TimelineSolution,DependencyMatrix, variance, mu, L, N, T);

attrgen = attrgen_norm;



bool1 = 0;
while bool1==0
    testfile = strcat('../../test/testdata/TimelineSolution',num2str(testdataiterator), '.dat');
    if exist(testfile, 'file') == 2
        testdataiterator = testdataiterator + 1;
    else
        bool1 = 1;
    end
end

% bool2 = 0;
% while bool2==0
%     testfile = strcat('../../test/testdata/TimelineSolution','B',num2str(testdataiterator(2)), '.dat');
%     if exist(testfile, 'file') == 2
%         testdataiterator(2) = testdataiterator(2) + 1;
%     else
%         bool2 = 1;
%     end
% end
% 
% bool3 = 0;
% while bool3==0
%     testfile = strcat('../../test/testdata/TimelineSolution','C',num2str(testdataiterator(3)), '.dat');
%     if exist(testfile, 'file') == 2
%         testdataiterator(3) = testdataiterator(3) + 1;
%     else
%         bool3 = 1;
%     end
% end



difficulty='A';
difficulty_number = 50;

%%%%%%%%%% Figur 1
f2 = figure('Visible','on','Position',[10,100,1400,1000]);

checkbox = uicontrol(f2,'Style','checkbox',...
                'String','Display dependencies (star denotes the endpoint of a dependency)',...
                'Units','normalized', ...
                'Value',0,'Position',[0.35 0.03 0.3 0.05], ...
                'Callback', @checkbox_callback);
            
    function checkbox_callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == 1)
            
            print_correct();
            
            print_arrows();
            
        else
            
            print_correct();
        end
    end

ha2 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.9,0.85]);

%%%%%%%%%% Figur 2
f = figure('Visible','on','Position',[160,200,1600,800]);

p = uipanel('Title','Data creation',...
    'Position',[0.04 0.02 0.92 0.93]);

testdatagen    = uicontrol('Style','pushbutton',...
    'String','Create test data', 'Units','normalized','Position',[0.75,0.2,0.2,0.05],...
    'Callback',@testdatagen_callback);

txtbox1 = uicontrol('Style','edit',...
    'String',num2str(L), 'Units','normalized',...
    'Position',[0.85 0.4 0.05 0.02],...
    'Callback',@txt1_callback);

    function txt1_callback(source,eventdata)
        L_prel = str2num(get(txtbox1,'String'));
        if isnumeric(L_prel) && ~isempty(L_prel) && ...
                L_prel > 0 && L_prel == floor(L_prel)
            
            L = L_prel;
        else
            set(txtbox1,'String',num2str(L));
            
        end
    end

txtbox2 = uicontrol('Style','edit',...
    'String',num2str(T), 'Units','normalized',...
    'Position',[0.85 0.45 0.05 0.02],...
    'Callback',@txt2_callback);

    function txt2_callback(source,eventdata)
        T_prel = str2num(get(txtbox2,'String'));
        if isnumeric(T_prel) && ~isempty(T_prel) && ...
                T_prel > 0 && T_prel == floor(T_prel)
            
            T = T_prel;
        else
            set(txtbox2,'String',num2str(T));
            
        end
    end

txtbox3 = uicontrol('Style','edit',...
    'String',num2str(N), 'Units','normalized',...
    'Position',[0.85 0.5 0.05 0.02],...
    'Callback',@txt3_callback);

    function txt3_callback(source,eventdata)
        N_prel = str2num(get(txtbox3,'String'));
        if isnumeric(N_prel) && ~isempty(N_prel) && ...
                N_prel > 0 && N_prel == floor(N_prel)
            
            N = N_prel;
        else
            set(txtbox3,'String',num2str(N));
            
        end
    end

txtbox4 = uicontrol('Style','edit',...
    'String',num2str(Num_data), 'Units','normalized',...
    'Position',[0.85 0.55 0.05 0.02],...
    'Callback',@txt4_callback);

    function txt4_callback(source,eventdata)
        Num_data_prel = str2num(get(txtbox4,'String'));
        if isnumeric(Num_data_prel) && ~isempty(Num_data_prel) && ...
                Num_data_prel > 0 && Num_data_prel == floor(Num_data_prel)
            
            Num_data = Num_data_prel;
        else
            set(txtbox4,'String',num2str(Num_data));
            
        end
    end

txtbox5 = uicontrol('Style','edit',...
    'String',num2str(Ndeps), 'Units','normalized',...
    'Position',[0.85 0.35 0.05 0.02],...
    'Callback',@txt5_callback);

    function txt5_callback(source,eventdata)
        Ndeps_prel = str2num(get(txtbox5,'String'));
        if isnumeric(Ndeps_prel) && ~isempty(Ndeps_prel) && ...
                Ndeps_prel > 0 && Ndeps_prel == floor(Ndeps_prel)
            
            Ndeps = Ndeps_prel;
        else
            set(txtbox5,'String',num2str(Ndeps));
            
        end
    end

static_text1 = uicontrol('Style','text','String','#Data sets:', 'Units','normalized',...
    'Position',[0.74,0.55,0.10,0.02]);

static_text2 = uicontrol('Style','text','String','#Tasks (approximately):', 'Units','normalized',...
    'Position',[0.74,0.5,0.10,0.02]);

static_text3 = uicontrol('Style','text','String','#Time-lines:', 'Units','normalized',...
    'Position',[0.74,0.45,0.10,0.02]);

static_text4 = uicontrol('Style','text','String','#Time steps:', 'Units','normalized',...
    'Position',[0.74,0.4,0.10,0.02]);

static_text5 = uicontrol('Style','text','String','#Dependencies (approximately):', 'Units','normalized',...
    'Position',[0.74,0.35,0.10,0.02]);

testdatasave    = uicontrol('Style','pushbutton',...
    'String','Save test data', 'Units','normalized','Position',[0.75,0.25,0.2,0.05],...
    'Callback',@testdatasave_callback);

    function testdatasave_callback(source,eventdata)
        if ~isempty(TimelineSolution_mater) && ~isempty(attributes_mater) && ~isempty(DependencyMatrix_mater) && ~isempty(DependencyAttribute_mater)
            UserFile1 = strcat('../../test/testdata/TimelineSolution',num2str(testdataiterator), '.dat');
            UserFile2 = strcat('../../test/testdata/TimelineAttributes',num2str(testdataiterator), '.dat');
            UserFile3 = strcat('../../test/testdata/DependencyMatrix',num2str(testdataiterator), '.dat');
            UserFile4 = strcat('../../test/testdata/DependencyAttributes',num2str(testdataiterator), '.dat');
            %         UserFile5 = strcat('../../test/testdata/Testinfo',num2str(testdataiterator), '.mat');
            %         fil1 = [];
            %         fil2 = [];
            %         for it=1:length(TimelineSolution)
            %             fil1 = [fil1; TimelineSolution{it}, it*ones(size(TimelineSolution{it},1),1)];
            %             fil2 = [fil2; attributes{it}, it*ones(size(TimelineSolution{it},1),1)];
            %         end
            fil1 = TimelineSolution_mater;
            fil2 = attributes_mater;
            fil3 = DependencyMatrix_mater;
            fil4 = DependencyAttribute_mater;
            
            
            %         fil5 = strcat('N = ', num2str(N), '\n', ...
            %             'L = ', num2str(L), '\n', ...
            %             'T = ', num2str(T), '\n', ...
            %             'Num_data = ', num2str(Num_data), '\n', ...
            %             'Ndeps = ', num2str(Ndeps), '\n', ...
            %             'occupancy = ', num2str(occupancy), '\n');
            %         fil5 = strcat('N');
            
            save(UserFile1, 'fil1', '-ascii')
            save(UserFile2, 'fil2', '-ascii')
            save(UserFile3, 'fil3', '-ascii')
            save(UserFile4, 'fil4', '-ascii')
            %         save(UserFile5, 'fil5')
            
            
            testdataiterator = testdataiterator+1;
        end
    end

launch_test_gui_btn    = uicontrol('Style','pushbutton',...
    'String','Launch testing GUI', 'Units','normalized','Position',[0.75,0.15,0.2,0.05],...
    'Callback',@launch_test_gui_callback);

    function launch_test_gui_callback(source,eventdata)
%         close(f3)
        test_gui();
        
    end

distribution_group = uibuttongroup(f,'Title','Temporal distribution of dependencies',...
    'Position',[.5 .25 .20 .08]);

temp_dist_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.15 0.2 0.04], ...
                'Callback',@temp_dist_cb);
            
    function temp_dist_cb(source,eventdata)
        
    end

distribution2_group = uibuttongroup(f,'Title','Maximum time between dependent tasks distribution',...
    'Position',[.5 .45 .20 .08]);

maxt_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.35 0.2 0.04], ...
                'Callback',@maxt_slider_cb);
            
    function maxt_slider_cb(source,eventdata)
        
    end

distribution3_group = uibuttongroup(f,'Title','Minimum starting time distribution',...
    'Position',[.05 .45 .20 .08]);

mstext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.1,0.39,0.1,0.03]);
            
ms_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.05 0.35 0.2 0.04], ...
                'Callback',@ms_slider_cb);
            
    function ms_slider_cb(source,eventdata)
        
    end

distribution4_group = uibuttongroup(f,'Title','Task length distribution',...
    'Position',[.275 .65 .20 .08]);

tlength_distr1 = uicontrol(distribution4_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@tlength_distr1_callback, ...
    'Tag', 'rab_mode1');

    function tlength_distr1_callback(source,eventdata)
        
    end

tlength_distr2 = uicontrol(distribution4_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@tlength_distr2_callback, ...
    'Tag', 'rab_mode2');

    function tlength_distr2_callback(source,eventdata)
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

correct_checkbox = uicontrol(f,'Style','checkbox',...
                'String','Rectify dependency probabilities based on task lengths',...
                'Units','normalized', ...
                'Value',0,'Position',[0.275 0.76 0.2 0.05], ...
                'Callback', @correct_checkbox_callback);
            
    function correct_checkbox_callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == 1)
            
            
        else
            
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tltext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.325,0.59,0.1,0.03]);
            
tl_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.55 0.2 0.04], ...
                'Callback',@tl_slider_cb);
            
    function tl_slider_cb(source,eventdata)
        
    end

distribution5_group = uibuttongroup(f,'Title','Deadline distribution',...
    'Position',[.275 .45 .20 .08]);

dead_distr1 = uicontrol(distribution5_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@dead_distr1_callback, ...
    'Tag', 'rab_mode1');

    function dead_distr1_callback(source,eventdata)
        
    end

dead_distr2 = uicontrol(distribution5_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@dead_distr2_callback, ...
    'Tag', 'rab_mode2');

    function dead_distr2_callback(source,eventdata)
        
    end

ddtext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.325,0.39,0.1,0.03]);
            
dd_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.35 0.2 0.04], ...
                'Callback',@dd_slider_cb);
            
    function dd_slider_cb(source,eventdata)
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distribution6_group = uibuttongroup(f,'Title','Minimum time between dependent tasks distribution',...
    'Position',[.5 .65 .20 .08]);

mint_distr1 = uicontrol(distribution6_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mint_distr1_callback, ...
    'Tag', 'rab_mode1');

    function mint_distr1_callback(source,eventdata)
        
    end

mint_distr2 = uicontrol(distribution6_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@mint_distr2_callback, ...
    'Tag', 'rab_mode2');

    function mint_distr2_callback(source,eventdata)
        
    end

mint_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.55 0.2 0.04], ...
                'Callback',@mint_slider_cb);
            
    function mint_slider_cb(source,eventdata)
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distribution7_group = uibuttongroup(f,'Title','Task spacing distribution',...
    'Position',[.05 .65 .20 .08]);

mode_distr1 = uicontrol(distribution7_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mode_distr1_callback, ...
    'Tag', 'rab_mode1');

    function mode_distr1_callback(source,eventdata)
        
    end

mode_distr2 = uicontrol(distribution7_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@mode_distr2_callback, ...
    'Tag', 'rab_mode2');

    function mode_distr2_callback(source,eventdata)
        
    end

mode_std_slider = uicontrol(f,'Style','slider',...
    'Min',0,'Max',100,'Value',50,...
    'SliderStep',[0.05 0.1], ...
    'Units','normalized',...
    'Position',[0.05 0.55 0.2 0.04], ...
    'Callback',@mode_std_cb);

    function mode_std_cb(source,eventdata)
        
    end

htext8  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.1,0.6,0.1,0.02]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mode_selector = uibuttongroup(f,'Title','Custom vs auto mode',...
    'Position',[.05 .85 .20 .08]);

mode_btn1 = uicontrol(mode_selector,'Style','radiobutton','String','Custom',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mode_btn1_callback, ...
    'Tag', 'rab_mode1');

    function mode_btn1_callback(source,eventdata)
        set(diff_slider,'Enable','off');
        set(htext7,'Enable','off');
    end

mode_btn2 = uicontrol(mode_selector,'Style','radiobutton','String','Auto',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@mode_btn2_callback, ...
    'Tag', 'rab_mode2');

    function mode_btn2_callback(source,eventdata)
        set(diff_slider,'Enable','on');
        set(diff_slider,'Value',difficulty_number);
        set(htext7,'Enable','on');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diff_type_selector = uibuttongroup(f,'Title','Continuous or discrete difficulties',...
    'Position',[.275 .85 .20 .08]);

diff_type_btn1 = uicontrol(diff_type_selector,'Style','radiobutton','String','Discrete',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@diff_type_btn1_callback, ...
    'Tag', 'rab_mode1');

    function diff_type_btn1_callback(source,eventdata)
        set(diff_slider,'Enable','off');
        set(htext7,'Enable','off');
    end

diff_type_btn2 = uicontrol(diff_type_selector,'Style','radiobutton','String','Continuous',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@diff_type_btn2_callback, ...
    'Tag', 'rab_mode2');

    function diff_type_btn2_callback(source,eventdata)
        set(diff_slider,'Enable','on');
        set(diff_slider,'Value',difficulty_number);
        set(htext7,'Enable','on');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
diff_slider = uicontrol(f,'Style','slider',...
    'Min',0,'Max',100,'Value',difficulty_number,...
    'SliderStep',[0.05 0.2], ...
    'Units','normalized',...
    'Position',[0.5 0.85 0.2 0.04], ...
    'Enable','off', ...
    'Callback',@diff_cb);

    function diff_cb(source,eventdata)
        difficulty_number = get(diff_slider,'Value');
    end

htext7  = uicontrol('Style','text','String','Level of difficulty:', 'Units','normalized',...
    'Position',[0.55,0.9,0.1,0.02], 'Enable','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distr1 = uicontrol(distribution_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@distr1_callback, ...
    'Tag', 'rab1');
distr2 = uicontrol(distribution_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@distr2_callback, ...
    'Tag', 'rab2');

distr3 = uicontrol(distribution2_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@distr3_callback, ...
    'Tag', 'rab1');
distr4 = uicontrol(distribution2_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@distr4_callback, ...
    'Tag', 'rab2');
distr5 = uicontrol(distribution3_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@distr5_callback, ...
    'Tag', 'rab1');
distr6 = uicontrol(distribution3_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@distr6_callback, ...
    'Tag', 'rab2');
%%%%%%%%%%%%%%%%
task_group = uibuttongroup(f,'Title','Task distribution across timelines',...
    'Position',[.05 .25 .20 .08]);

taskdstr1 = uicontrol(task_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@taskdstr1_callback, ...
    'Tag', 'rab1');
taskdstr2 = uicontrol(task_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@taskdstr2_callback, ...
    'Tag', 'rab2');

    function taskdstr1_callback(source,eventdata)
        
        
    end


    function taskdstr2_callback(source,eventdata)
        
        
    end

tdt_text  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.1,0.19,0.1,0.03]);
            
tdt_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.05 0.15 0.2 0.04], ...
                'Callback',@tdt_slider_cb);
            
    function tdt_slider_cb(source,eventdata)
        
    end

%%%%%%% Dependencies spatial distribution %%%%%%
depspat_group = uibuttongroup(f,'Title','Spatial distribution of dependencies',...
    'Position',[.275 .25 .20 .08]);

depspat_dstr1 = uicontrol(depspat_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@depspat_dstr1_callback, ...
    'Tag', 'rab1');
depspat_dstr2 = uicontrol(depspat_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@depspat_dstr2_callback, ...
    'Tag', 'rab2');

    function depspat_dstr1_callback(source,eventdata)
        
        
    end


    function depspat_dstr2_callback(source,eventdata)
        
        
    end

depspat_text  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.325,0.19,0.1,0.03]);
            
depspat_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.15 0.2 0.04], ...
                'Callback',@depspat_slider_cb);
            
    function depspat_slider_cb(source,eventdata)
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

htext1  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.55,0.6,0.10,0.02]);

htext2  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.55,0.39,0.10,0.03]);

htext3  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.55,0.19,0.10,0.03]);

% htext3  = uicontrol('Style','text','String','Sparseness:', 'Units','normalized',...
%     'Position',[0.81,0.9,0.08,0.03]);


% txtbox1 = uicontrol('Style','edit',...
%     'String',num2str(12), 'Units','normalized',...
%     'Position',[0.735 0.82 0.03 0.02],...
%     'Callback',@txtbox1_callback);

% uicontrol(f,'Style','slider',...
%                 'Min',0,'Max',100,'Value',25,...
%                 'SliderStep',[0.05 0.2], ...
%                 'Units','normalized',...
%                 'Position',[0.71 0.87 0.08 0.02]);
            
% uicontrol(f,'Style','slider',...
%                 'Min',0,'Max',100,'Value',25,...
%                 'SliderStep',[0.05 0.2], ...
%                 'Units','normalized',...
%                 'Position',[0.81 0.87 0.08 0.02]);


% uicontrol(f,'Style','slider',...
%                 'Min',0,'Max',100,'Value',25,...
%                 'SliderStep',[0.05 0.2], ...
%                 'Units','normalized',...
%                 'Position',[0.71 0.67 0.08 0.02]);
% 
% uicontrol(f,'Style','slider',...
%                 'Min',0,'Max',100,'Value',25,...
%                 'SliderStep',[0.05 0.2], ...
%                 'Units','normalized',...
%                 'Position',[0.71 0.77 0.08 0.02]);
            
            

htext6  = uicontrol('Style','text','String','Level of occupancy:', 'Units','normalized',...
    'Position',[0.1,0.79,0.1,0.03]);
            
slider5 = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',0.5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.05 0.75 0.2 0.04], ...
                'Callback',@slider5_cb);
            
    function slider5_cb(source,eventdata)
        occupancy = get(slider5,'Value');
    end

    function distr1_callback(source,eventdata)
        
    end

    function distr2_callback(source,eventdata)
        
    end

    function distr3_callback(source,eventdata)
        
    end

    function distr4_callback(source,eventdata)
        
    end

    function distr5_callback(source,eventdata)
        attrgen = attrgen_norm;
    end

    function distr6_callback(source,eventdata)
        attrgen = attrgen_unif;
    end

    function testdatagen_callback(source,eventdata)
        
        set(checkbox,'Value',0);
        
        % Hämta information från var knapparna befinner sig.
        TimelineSolution_mater = [];
        attributes_mater = [];
        DependencyMatrix_mater = [];
        DependencyAttribute_mater = [];
        TimelineSolution = [];
        attributes = [];
        DependencyMatrix = [];
        DependencyAttribute = [];
        
        for it=1:Num_data
            [ TimelineSolution, attributes, DependencyMatrix, DependencyAttribute ] = Testdatagenerator(N, L, T, genlistoflen, ...
                genlistofstartpts,gentasks, attrgen, ...
                gendepmatrix,gendepattr, Ndeps, 1, 1, 1, 1, occupancy, genlistoflst);
            
            for k=1:length(TimelineSolution)
                TimelineSolution_mater = [TimelineSolution_mater; TimelineSolution{k}, k*ones(size(TimelineSolution{k},1),1), it*ones(size(TimelineSolution{k},1),1)];
                attributes_mater = [attributes_mater; attributes{k}, k*ones(size(attributes{k},1),1), it*ones(size(attributes{k},1),1)];
            end
            DependencyMatrix_mater = [DependencyMatrix_mater; DependencyMatrix, it*ones(size(DependencyMatrix,1),1)];
            DependencyAttribute_mater = [DependencyAttribute_mater; DependencyAttribute, it*ones(size(DependencyAttribute,1),1)];
        end
        
        
        % Måste konvertera lång Timelinesolution och attributes till
        % cell-array vid inläsning.
        
        % Visualisera testdata!!
        print_correct();
    end

    function load_file
        
    end

    function save_file
        
    end

    % Funktion som skriver ut inläst fil, om filen sparades korrekt, ritar
    % ut resultatet av en körning, etc.
    function print_correct
        
        
        % Visualisera testdata:
        set(0, 'currentfigure', f2);
        
        set(f2, 'currentaxes', ha2);
        
        cla reset
        
        axis([-0.1*L,1.1*L,0,T+1])
        set(gca,'FontSize',10);
        title('Plot of timelines and tasks');
        xlabel('Time');
        ylabel('Time-line');
        hold(ha2, 'on')
        Color = diag(ones(3,1));
        for i=1:length(TimelineSolution)
            for k=1:size(TimelineSolution{i},1)
                % Rita ut gröna linjer för varje task.
                line([TimelineSolution{i}(k,1) TimelineSolution{i}(k,1)+TimelineSolution{i}(k,2)], [i i], 'Color',Color(1+mod(k,3),:));
            end
        end
        
        hold(ha2, 'off')
        set(0, 'currentfigure', f);
        
    end

    function print_arrows
        for i=1:size(DependencyMatrix,1)
            set(0, 'currentfigure', f2);
            
            set(f2, 'currentaxes', ha2);
            hold(ha2, 'on')
            task1_start = TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),1);
            task1_length = TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),2);
            task2_start = TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),1);
            
            x_start = task1_start+task1_length;
            x_end = task2_start;
            y_start = DependencyMatrix(i,2);
            y_end = DependencyMatrix(i,4);
            
            % line([x_start, x_end], [y_start, y_end],'Color',[0.1,0.8,0.1])
            
            
            
            X = [x_start x_end];
            Y = [y_start y_end];
            % intermediate point (you have to choose your own)
            Xi = mean(X);
            Yi = mean(Y) + 0.5*(y_end-y_start)+0.1;
            
            Xa = [X(1) Xi X(2)];
            Ya = [Y(1) Yi Y(2)];
            
            t  = 1:numel(Xa);
            ts = linspace(min(t),max(t),numel(Xa)*10); % has to be a fine grid
            xx = spline(t,Xa,ts);
            yy = spline(t,Ya,ts);
            
            plot(xx,yy); hold on; % curve
            
            
            plot(x_end,y_end,'Marker','p','Color',[.88 .48 0],'MarkerSize',10)
            hold(ha2, 'off')
            set(0, 'currentfigure', f);
        end
    end

end
