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
L = 1000000000;

% Antal tidslinjer
T = 10;

% Antal data att skapa
Num_data = 1;

% Antal dependencies
Ndeps=20;

% Hur stor del av tidlinjerna som är besatta
occupancy = 0.5;

% Inga dependencies mellan timelines?
constrain = 0;

% Olika standardavvikelser

std1 = 0.5;
std2 = 0.5;
std3 = 0.5;
std4 = 0.5;
std5 = 0.5;
std6 = 0.5;
std7 = 0.5;
std8 = 0.5;
std9 = 0.5;

% Väntevärden för några fördelningar

mu1 = 1;
mu2 = 2;
mu3 = 3;
mu4 = 4;

% Korrigera dependencysannolikheter baserat på task lengths.

rectify = 0;

% Funktionsdefinitioner

norm_distr = @(mu, sigma) normal_distribution(mu, sigma);
unif_distr = @(mu, sigma) uniform_distribution(mu, sigma);


genlistoflen = @(listofstartingpoints,L) generatelistoflength(listofstartingpoints,L);
genlistoflst = @(L, N, occupancy, distrib4, std4, std7, distrib7) genlistoflengths_startpts(L, N, occupancy, distrib4, std4, std7, distrib7);
genlistofstartpts = @(L, N) generatelistofstartingpoints(L, N);
gentasks = @( Ntasks, Ntimelines, distrib8, std8 ) generateNumberoftasksinTimelinevector( Ntasks, Ntimelines, distrib8, std8 );
attrgen_unif = @(TimelineSolution,L,variance,mu) Attributegenerator_uniform(TimelineSolution,L,variance,mu);
attrgen_norm = @(TimelineSolution,L,variance,mu) Attributegenerator_norm(TimelineSolution,L,variance,mu);
gendepmatrix = @(TimelineSolution, Ndependencies, variance, mu, rectify,constrain) Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu, rectify,constrain);
gendepattr = @(TimelineSolution,DependencyMatrix, variance, mu, L, N, T, distrib6, std6, mu4, std2, distrib2, mu2) Generatedependencyattributes(TimelineSolution,DependencyMatrix, variance, mu, L, N, T, distrib6, std6, mu4, std2, distrib2, mu2);

attrgen = attrgen_norm;

distrib1 = norm_distr;
distrib2 = norm_distr;
distrib3 = norm_distr;
distrib4 = norm_distr;
distrib5 = norm_distr;
distrib6 = norm_distr;
distrib7 = norm_distr;
distrib8 = norm_distr;
distrib9 = norm_distr;

dist_sel1 = 0;
dist_sel2 = 0;
dist_sel3 = 0;
dist_sel4 = 0;
dist_sel5 = 0;
dist_sel6 = 0;
dist_sel7 = 0;
dist_sel8 = 0;
dist_sel9 = 0;


difficulty='A';
difficulty_number = 50;

bool1 = 0;

while bool1==0
    testfile = strcat('../../../test/testdata/TimelineSolution',num2str(testdataiterator), '.dat');
    if exist(testfile, 'file') == 2
        testdataiterator = testdataiterator + 1;
    else
        bool1 = 1;
    end
end

% bool2 = 0;
% while bool2==0
%     testfile = strcat('../../../test/testdata/TimelineSolution','B',num2str(testdataiterator(2)), '.dat');
%     if exist(testfile, 'file') == 2
%         testdataiterator(2) = testdataiterator(2) + 1;
%     else
%         bool2 = 1;
%     end
% end
% 
% bool3 = 0;
% while bool3==0
%     testfile = strcat('../../../test/testdata/TimelineSolution','C',num2str(testdataiterator(3)), '.dat');
%     if exist(testfile, 'file') == 2
%         testdataiterator(3) = testdataiterator(3) + 1;
%     else
%         bool3 = 1;
%     end
% end

%%%%%%%%%% Figur som visar tasks och dependencies
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

%%%%%%%%%% Figur som visar tasks deadlines och min. starttider
f3 = figure('Visible','on','Position',[10,100,1400,1000]);

ha3 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.7,0.85]);

listbox1 = uicontrol(f3,'Style','listbox',...
    'Units','normalized',...
    'Position',[0.78 0.1 0.2 0.5],'Value',1, ...
    'Callback', @listbox1_callback);

listbox1_text = uicontrol('Style','text','String','Timeline selector', 'Units','normalized',...
    'Position',[0.78,0.6,0.2,0.02]);

timeline_selection = 1;

    function listbox1_callback(hObject, eventdata, handles)
        index_selected = get(hObject,'Value');
        timeline_selection = index_selected;
        print_correct();
    end

%%%%%%%%%% Figur som visar dependency attributes
f4 = figure('Visible','on','Position',[10,100,1400,1000]);

ha4 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.9,0.85]);

%%%%%%%%%% Figur för GUI:t
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
                Ndeps_prel >= 0 && Ndeps_prel == floor(Ndeps_prel)
            
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
            UserFile1 = strcat('../../../test/testdata/TimelineSolution',num2str(testdataiterator), '.dat');
            UserFile2 = strcat('../../../test/testdata/TimelineAttributes',num2str(testdataiterator), '.dat');
            UserFile3 = strcat('../../../test/testdata/DependencyMatrix',num2str(testdataiterator), '.dat');
            UserFile4 = strcat('../../../test/testdata/DependencyAttributes',num2str(testdataiterator), '.dat');
            UserFile5 = strcat('../../../test/testdata/Testinfo',num2str(testdataiterator), '.dat');
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
            
            % Två olika lägen beroende på vad användaren har valt!
            
            % Ska det exakta antalet tasks och deps. skrivas in eller
            % räcker väntevärdet?
            fil5 = [N, L, T, Num_data, Ndeps, occupancy, constrain, rectify, std1, std2, std3, std4, std5, std6, std7, std8, std9, ...
                mu1, mu2, mu3, mu4, difficulty_number, dist_sel1, dist_sel2, dist_sel3, dist_sel4, dist_sel5, dist_sel6, dist_sel7, dist_sel8, ...
                dist_sel9]';
            
            
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
            save(UserFile5, 'fil5', '-ascii')
            
            
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

    function distr1_callback(source,eventdata)
        distrib1 = norm_distr;
        dist_sel1 = 0;
    end

    function distr2_callback(source,eventdata)
        distrib1 = unif_distr;
        dist_sel1 = 1;
    end

set(allchild(distribution_group),'Enable','off');

temp_dist_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std1,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.15 0.2 0.04], ...
                'Callback',@temp_dist_cb);
            
    function temp_dist_cb(source,eventdata)
        std1 = get(temp_dist_slider,'Value');
    end

htext3  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.55,0.19,0.10,0.03]);

set(temp_dist_slider,'Enable','off');
set(htext3,'Enable','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Max time between dep tasks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
htext21  = uicontrol('Style','text','String','Mean value:', 'Units','normalized',...
    'Position',[0.6,0.39,0.10,0.03]);

htext2  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.5,0.39,0.10,0.03]);

distribution2_group = uibuttongroup(f,'Title','Maximum time between dependent tasks distribution',...
    'Position',[.5 .45 .20 .08]);

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

    function distr3_callback(source,eventdata)
        distrib2 = norm_distr;
        dist_sel2 = 0;
    end

    function distr4_callback(source,eventdata)
        distrib2 = unif_distr;
        dist_sel2 = 1;
    end


maxt_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std2,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.35 0.1 0.04], ...
                'Callback',@maxt_slider_cb);
            
    function maxt_slider_cb(source,eventdata)
        std2 = get(maxt_slider,'Value');
    end

maxt2_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',mu2,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.6 0.35 0.1 0.04], ...
                'Callback',@maxt2_slider_cb);
            
    function maxt2_slider_cb(source,eventdata)
        mu2 = get(maxt2_slider,'Value');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Min start time distr%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distribution3_group = uibuttongroup(f,'Title','Minimum starting time distribution',...
    'Position',[.05 .45 .20 .08]);

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

    function distr5_callback(source,eventdata)
        attrgen = attrgen_norm;
        distrib3 = norm_distr;
        dist_sel3 = 0;
    end

    function distr6_callback(source,eventdata)
        attrgen = attrgen_unif;
        distrib3 = unif_distr;
        dist_sel3 = 1;
    end

mstext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.05,0.39,0.1,0.03]);
            
ms_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std3,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.05 0.35 0.1 0.04], ...
                'Callback',@ms_slider_cb);
            
    function ms_slider_cb(source,eventdata)
        std3 = get(ms_slider,'Value');
    end

ms2text  = uicontrol('Style','text','String','Mean value:', 'Units','normalized',...
    'Position',[0.15,0.39,0.1,0.03]);
            
ms2_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',mu1,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.15 0.35 0.1 0.04], ...
                'Callback',@ms2_slider_cb);
            
    function ms2_slider_cb(source,eventdata)
        mu1 = get(ms2_slider,'Value');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%% task length %%%%%%%%%%%%%%%%%%%%%%%%%%%%

tltext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.325,0.59,0.1,0.03]);
            
tl_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std4,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.55 0.2 0.04], ...
                'Callback',@tl_slider_cb);
            
    function tl_slider_cb(source,eventdata)
        std4 = get(tl_slider,'Value');
    end

distribution4_group = uibuttongroup(f,'Title','Task length distribution',...
    'Position',[.275 .65 .20 .08]);

tlength_distr1 = uicontrol(distribution4_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@tlength_distr1_callback, ...
    'Tag', 'rab_mode1');

    function tlength_distr1_callback(source,eventdata)
        distrib4 = norm_distr;
        dist_sel4 = 0;
    end

tlength_distr2 = uicontrol(distribution4_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@tlength_distr2_callback, ...
    'Tag', 'rab_mode2');

    function tlength_distr2_callback(source,eventdata)
        distrib4 = unif_distr;
        dist_sel4 = 1;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

correct_checkbox = uicontrol(f,'Style','checkbox',...
                'String','Rectify dependency probabilities based on task lengths',...
                'Units','normalized', ...
                'Value',0,'Position',[0.275 0.74 0.2 0.05], ...
                'Callback', @correct_checkbox_callback);
            
    function correct_checkbox_callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == 1)
            rectify = 1;
        else
            rectify = 0;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constrain_checkbox = uicontrol(f,'Style','checkbox',...
                'String','Constrain dependencies to stay within a single timeline',...
                'Units','normalized', ...
                'Value',0,'Position',[0.275 0.78 0.2 0.05], ...
                'Callback', @constrain_checkbox_callback);
            
    function constrain_checkbox_callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == 1)
            constrain = 1;
        else
            constrain = 0;
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%deadline dist%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distribution5_group = uibuttongroup(f,'Title','Deadline distribution',...
    'Position',[.275 .45 .20 .08]);

dead_distr1 = uicontrol(distribution5_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@dead_distr1_callback, ...
    'Tag', 'rab_mode1');

    function dead_distr1_callback(source,eventdata)
        distrib5 = norm_distr;
        dist_sel5 = 0;
    end

dead_distr2 = uicontrol(distribution5_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@dead_distr2_callback, ...
    'Tag', 'rab_mode2');

    function dead_distr2_callback(source,eventdata)
        distrib5 = unif_distr;
        dist_sel5 = 1;
    end

ddtext  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.275,0.39,0.1,0.03]);
            
dd_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std5,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.35 0.1 0.04], ...
                'Callback',@dd_slider_cb);
            
    function dd_slider_cb(source,eventdata)
        std5 = get(dd_slider,'Value');
    end

ddtext2  = uicontrol('Style','text','String','Mean value:', 'Units','normalized',...
    'Position',[0.375,0.39,0.1,0.03]);
            
dd2_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',mu3,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.375 0.35 0.1 0.04], ...
                'Callback',@dd2_slider_cb);
            
    function dd2_slider_cb(source,eventdata)
        mu3 = get(dd2_slider,'Value');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%min time between dep tasks%%%%%%%%%%%%%%%%%%%%%%
htext1  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.5,0.6,0.10,0.02]);
htext12  = uicontrol('Style','text','String','Mean value:', 'Units','normalized',...
    'Position',[0.6,0.6,0.10,0.02]);

distribution6_group = uibuttongroup(f,'Title','Minimum time between dependent tasks distribution',...
    'Position',[.5 .65 .20 .08]);

mint_distr1 = uicontrol(distribution6_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mint_distr1_callback, ...
    'Tag', 'rab_mode1');

    function mint_distr1_callback(source,eventdata)
        distrib6 = norm_distr;
        dist_sel6 = 0;
    end

mint_distr2 = uicontrol(distribution6_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@mint_distr2_callback, ...
    'Tag', 'rab_mode2');

    function mint_distr2_callback(source,eventdata)
        distrib6 = unif_distr;
        dist_sel6 = 1;
    end

mint_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std6,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.5 0.55 0.1 0.04], ...
                'Callback',@mint_slider_cb);
            
    function mint_slider_cb(source,eventdata)
        std6 = get(mint_slider,'Value');
    end

mint2_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',mu4,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.6 0.55 0.1 0.04], ...
                'Callback',@mint2_slider_cb);
            
    function mint2_slider_cb(source,eventdata)
        mu4 = get(mint2_slider,'Value');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Task spacing distr%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distribution7_group = uibuttongroup(f,'Title','Task spacing distribution',...
    'Position',[.05 .65 .20 .08]);

mode_distr1 = uicontrol(distribution7_group,'Style','radiobutton','String','Normal',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mode_distr1_callback, ...
    'Tag', 'rab_mode1');

    function mode_distr1_callback(source,eventdata)
        distrib7 = norm_distr;
        dist_sel7 = 0;
    end

mode_distr2 = uicontrol(distribution7_group,'Style','radiobutton','String','Uniform',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@mode_distr2_callback, ...
    'Tag', 'rab_mode2');

    function mode_distr2_callback(source,eventdata)
        distrib7 = unif_distr;
        dist_sel7 = 1;
    end

mode_std_slider = uicontrol(f,'Style','slider',...
    'Min',0.05,'Max',0.95,'Value',std7,...
    'SliderStep',[0.05 0.1], ...
    'Units','normalized',...
    'Position',[0.05 0.55 0.2 0.04], ...
    'Callback',@mode_std_cb);

    function mode_std_cb(source,eventdata)
        std7 = get(mode_std_slider,'Value');
    end

htext8  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.1,0.6,0.1,0.02]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mode_selector = uibuttongroup(f,'Title','Extended or simplified mode',...
    'Position',[.05 .85 .20 .08]);

mode_btn1 = uicontrol(mode_selector,'Style','radiobutton','String','Extended',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@mode_btn1_callback, ...
    'Tag', 'rab_mode1');

mode_btn2 = uicontrol(mode_selector,'Style','radiobutton','String','Simplified, for dummies',...
    'Units','normalized',...
    'Position',[.4 .3 .6 .4], ...
    'Callback',@mode_btn2_callback, ...
    'Tag', 'rab_mode2');


%% Simple GUI: dependencies %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dep_group = uibuttongroup(f,'Title','Dependencies intensity',...
    'Position',[.725 .65 .20 .08]);

dep_low = uicontrol(dep_group,'Style','radiobutton','String','Low',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@dep_low_callback, ...
    'Tag', 'rab_mode1');

    function dep_low_callback(source,eventdata)
        
    end

dep_high = uicontrol(dep_group,'Style','radiobutton','String','High',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@dep_high_callback, ...
    'Tag', 'rab_mode2');

    function dep_high_callback(source,eventdata)
        
    end

%% Simple GUI: attributes interval %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

attr_group = uibuttongroup(f,'Title','Attributes intervals',...
    'Position',[.725 .75 .20 .08]);

attr_short = uicontrol(attr_group,'Style','radiobutton','String','Short',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@attr_short_callback, ...
    'Tag', 'rab_mode1');

    function attr_short_callback(source,eventdata)
        
    end

attr_long = uicontrol(attr_group,'Style','radiobutton','String','Long',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@attr_long_callback, ...
    'Tag', 'rab_mode2');

    function attr_long_callback(source,eventdata)
        
    end

%% Simple GUI: density of tasks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

density_group = uibuttongroup(f,'Title','Task density',...
    'Position',[.5 .75 .20 .08]);

density_low = uicontrol(density_group,'Style','radiobutton','String','Low',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@density_low_callback, ...
    'Tag', 'rab_mode1');

    function density_low_callback(source,eventdata)
        
    end

density_high = uicontrol(density_group,'Style','radiobutton','String','High',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@density_high_callback, ...
    'Tag', 'rab_mode2');

    function density_high_callback(source,eventdata)
        
    end

%% Simple GUI: dependency intervals %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

depattr_group = uibuttongroup(f,'Title','Dependency Attributes intervals',...
    'Position',[.725 .85 .20 .08]);

depattr_short = uicontrol(depattr_group,'Style','radiobutton','String','Short',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@depattr_short_callback, ...
    'Tag', 'rab_mode1');

    function depattr_short_callback(source,eventdata)
        
    end

depattr_long = uicontrol(depattr_group,'Style','radiobutton','String','Long',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@depattr_long_callback, ...
    'Tag', 'rab_mode2');

    function depattr_long_callback(source,eventdata)
        
    end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(allchild(dep_group),'Enable','off');
set(allchild(depattr_group),'Enable','off');
set(allchild(attr_group),'Enable','off');
set(allchild(density_group),'Enable','off');

    function mode_btn1_callback(source,eventdata)
        set(diff_slider,'Enable','off');
        set(htext7,'Enable','off');
        
        set(allchild(dep_group),'Enable','off');
        set(allchild(depattr_group),'Enable','off');
        set(allchild(attr_group),'Enable','off');
        
        set(allchild(density_group),'Enable','off');
        
        % Ett fåtal disables, massa enables
        set(htext8,'Enable','on');
        set(tdt_slider,'Enable','on');
        set(tdt_text,'Enable','on');
%         set(allchild(depspat_group),'Enable','on');
%         set(depspat_slider,'Enable','on');
%         set(depspat_text,'Enable','on');
        set(slider5,'Enable','on');
%         set(temp_dist_slider,'Enable','on');
        set(maxt_slider,'Enable','on');
        set(ms_slider,'Enable','on');
        set(allchild(distribution4_group),'Enable','on');
        set(allchild(distribution7_group),'Enable','on');
        set(tl_slider,'Enable','on');
        set(dd_slider,'Enable','on');
        set(ddtext,'Enable','on');
        set(mint_slider,'Enable','on');
        set(mode_std_slider,'Enable','on');
        
        set(htext1,'Enable','on');
        set(htext2,'Enable','on');
%         set(htext3,'Enable','on');
        set(htext6,'Enable','on');
        
        set(mstext,'Enable','on');
        set(tltext,'Enable','on');
        
%         set(allchild(distribution_group),'Enable','on');
        set(allchild(distribution2_group),'Enable','on');
        set(allchild(distribution3_group),'Enable','on');
        set(allchild(distribution5_group),'Enable','on');
        set(allchild(distribution6_group),'Enable','on');
        set(allchild(task_group),'Enable','on');
        
        set(mint2_slider,'Enable','on');
        set(ms2text,'Enable','on');
        set(ms2_slider,'Enable','on');
        set(dd2_slider,'Enable','on');
        set(ddtext2,'Enable','on');
        set(maxt2_slider,'Enable','on');
        set(htext12,'Enable','on');
        set(htext21,'Enable','on');
        
        set(static_text2,'Enable','on');
        set(static_text3,'Enable','on');
        set(static_text4,'Enable','on');
        set(static_text5,'Enable','on');
        
        set(txtbox1,'Enable','on');
        set(txtbox2,'Enable','on');
        set(txtbox3,'Enable','on');
        set(txtbox5,'Enable','on');
        
        set(correct_checkbox,'Enable','on'); 
        set(constrain_checkbox,'Enable','on'); 
    end

    function mode_btn2_callback(source,eventdata)
        
        set(allchild(dep_group),'Enable','on');
        set(allchild(depattr_group),'Enable','on');
        set(allchild(attr_group),'Enable','on');
        
        
        set(diff_slider,'Enable','on');
        set(diff_slider,'Value',difficulty_number);
        set(htext7,'Enable','on');
        
        set(allchild(density_group),'Enable','on');
        
        % Ett fåtal enables, massa disables
        set(htext8,'Enable','off');
        
        set(tdt_slider,'Enable','off');
        set(tdt_text,'Enable','off');
%         set(allchild(depspat_group),'Enable','off');
%         set(depspat_slider,'Enable','off');
        set(slider5,'Enable','off');
%         set(temp_dist_slider,'Enable','off');
        set(maxt_slider,'Enable','off');
        set(ms_slider,'Enable','off');
        set(allchild(distribution4_group),'Enable','off');
        set(allchild(distribution7_group),'Enable','off');
        set(tl_slider,'Enable','off');
        set(dd_slider,'Enable','off');
        set(ddtext,'Enable','off');
        set(mint_slider,'Enable','off');
        set(mode_std_slider,'Enable','off');
        
        set(htext1,'Enable','off');
        set(htext2,'Enable','off');
%         set(htext3,'Enable','off');
        set(htext6,'Enable','off');
        
%         set(depspat_text,'Enable','off');
        set(mstext,'Enable','off');
        set(tltext,'Enable','off');
        
%         set(allchild(distribution_group),'Enable','off');
        set(allchild(distribution2_group),'Enable','off');
        set(allchild(distribution3_group),'Enable','off');
        set(allchild(distribution5_group),'Enable','off');
        set(allchild(distribution6_group),'Enable','off');
        set(allchild(task_group),'Enable','off');
        
        set(mint2_slider,'Enable','off');
        set(ms2text,'Enable','off');
        set(ms2_slider,'Enable','off');
        set(dd2_slider,'Enable','off');
        set(ddtext2,'Enable','off');
        set(maxt2_slider,'Enable','off');
        set(htext12,'Enable','off');
        set(htext21,'Enable','off');
        
        set(static_text2,'Enable','off');
        set(static_text3,'Enable','off');
        set(static_text4,'Enable','off');
        set(static_text5,'Enable','off');
        
        set(txtbox1,'Enable','off');
        set(txtbox2,'Enable','off');
        set(txtbox3,'Enable','off');
        set(txtbox5,'Enable','off');
        
        set(correct_checkbox,'Enable','off'); 
        set(constrain_checkbox,'Enable','off'); 
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diff_type_selector = uibuttongroup(f,'Title','Continuous or discrete difficulties',...
    'Position',[.275 .85 .20 .08]);

diff_type_btn1 = uicontrol(diff_type_selector,'Style','radiobutton','String','Continuous',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@diff_type_btn1_callback, ...
    'Tag', 'rab_mode1');

    function diff_type_btn1_callback(source,eventdata)
        
    end

diff_type_btn2 = uicontrol(diff_type_selector,'Style','radiobutton','String','Discrete',...
    'Units','normalized',...
    'Position',[.6 .3 .6 .4], ...
    'Callback',@diff_type_btn2_callback, ...
    'Tag', 'rab_mode2');

    function diff_type_btn2_callback(source,eventdata)
        
        set(diff_slider,'Value',difficulty_number);
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
        distrib8 = norm_distr;
        dist_sel8 = 0;
        
    end


    function taskdstr2_callback(source,eventdata)
        distrib8 = unif_distr;
        dist_sel8 = 1;
    end

tdt_text  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.1,0.19,0.1,0.03]);
            
tdt_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std8,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.05 0.15 0.2 0.04], ...
                'Callback',@tdt_slider_cb);
            
    function tdt_slider_cb(source,eventdata)
        std8 = get(tdt_slider,'Value');
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
        distrib9 = norm_distr;
        dist_sel9 = 0;
    end


    function depspat_dstr2_callback(source,eventdata)
        distrib9 = unif_distr;
        dist_sel9 = 1;
    end

depspat_text  = uicontrol('Style','text','String','Standard deviation:', 'Units','normalized',...
    'Position',[0.325,0.19,0.1,0.03]);
            
depspat_slider = uicontrol(f,'Style','slider',...
                'Min',0.05,'Max',0.95,'Value',std9,...
                'SliderStep',[0.05 0.1], ...
                'Units','normalized',...
                'Position',[0.275 0.15 0.2 0.04], ...
                'Callback',@depspat_slider_cb);
            
    function depspat_slider_cb(source,eventdata)
        std9 = get(depspat_slider,'Value');
    end

set(allchild(depspat_group),'Enable','off');
set(depspat_slider,'Enable','off');
set(depspat_text,'Enable','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
                gendepmatrix,gendepattr, Ndeps, 1, 1, 1, 1, occupancy, genlistoflst, rectify, std1,std2,std3,std4,std5,std6,std7,std8, ...
                std9,mu1,mu2,mu3,mu4,distrib1,distrib2,distrib3,distrib4,distrib5,distrib6,distrib7,distrib8,distrib9,constrain);
            
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        set(0, 'currentfigure', f3);
        
        % Rita ut dependency attributes som en kulspruta.
        % Behövs en grej där man kan välja för vilken timeline man ska visa
        % attributes.
        
        xlevel=size(TimelineSolution{timeline_selection},1);
        
        if ~isempty(TimelineSolution)
            prel_string = 1:length(TimelineSolution);
            
            string1 = mat2cell(prel_string,1,ones(1,size(prel_string,2)));
            
            set(listbox1,'String',string1);
        end
        set(f3, 'currentaxes', ha3);
        
        cla reset
        
        set(gca,'FontSize',10);
        title('Plot of tasks and task attributes');
        xlabel('Time');
        ylabel('Tasks');
        axis([-0.1*L,1.1*L,-0.1*xlevel,1.1*xlevel])
        hold(ha3, 'on')
        
        % Måste göra en lista med timelines där deadline <= min starting
        % time.
        for k=1:size(TimelineSolution{timeline_selection},1)
            i = timeline_selection;
            % Rita ut gröna linjer för varje task.
            line([attributes{i}(k,1) TimelineSolution{i}(k,1)], [k k], 'Color',[0.5 0.5 0.5]);
            line([TimelineSolution{i}(k,1) TimelineSolution{i}(k,1)+TimelineSolution{i}(k,2)], [k k], 'Color',Color(1+mod(k,3),:));
            line([TimelineSolution{i}(k,1)+TimelineSolution{i}(k,2) attributes{i}(k,2)], [k k], 'Color',[0.5 0.5 0.5]);
        end
        
        hold(ha3, 'off')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        set(0, 'currentfigure', f4);
        
        set(f4, 'currentaxes', ha4);
        
        cla reset
        
        xlevel2 = size(DependencyMatrix,1);
        
        set(gca,'FontSize',10);
        title('Plot of dependencies and dependency attributes');
        xlabel('Time');
        ylabel('Dependencies');
        
        if xlevel2 > 0
            axis([-0.1*L,1.1*L,-0.1*xlevel2,1.1*xlevel2])
            hold(ha4, 'on')
            
            % Måste göra en lista med timelines där deadline <= min starting
            % time.
            for k=1:xlevel2
                
                task1_start = TimelineSolution{DependencyMatrix(k,2)}(DependencyMatrix(k,1),1);
                task1_length = TimelineSolution{DependencyMatrix(k,2)}(DependencyMatrix(k,1),2);
                task2_start = TimelineSolution{DependencyMatrix(k,4)}(DependencyMatrix(k,3),1);
                
                fdmin = DependencyAttribute(k,1);
                fdmax = DependencyAttribute(k,2);
                
                % Rita ut gröna linjer för varje task.
                line([task1_start task1_start+task1_length], [k k], 'Color',Color(1+mod(k,3),:));
                line([task1_start+task1_length+fdmin task1_start+task1_length+fdmax], [k k], 'Color',[0.5 0.5 0.5]);
                plot(task2_start,k,'Marker','p','Color',[.88 .48 0],'MarkerSize',7)
            end
            
            hold(ha4, 'off')
        end
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
