% Här måste vi kunna läsa/skriva testdata ifrån en fil.

function GUI

close all;

TimelineSolution = [];
attributes = [];
DependencyMatrix = [];
DependencyAttribute = [];

testdataiterator = ones(3,1);

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


bool1 = 0;
while bool1==0
    testfile = strcat('../../test/testdata/TimelineSolution','A',num2str(testdataiterator(1)), '.dat');
    if exist(testfile, 'file') == 2
        testdataiterator(1) = testdataiterator(1) + 1;
    else
        bool1 = 1;
    end
end

bool2 = 0;
while bool2==0
    testfile = strcat('../../test/testdata/TimelineSolution','B',num2str(testdataiterator(2)), '.dat');
    if exist(testfile, 'file') == 2
        testdataiterator(2) = testdataiterator(2) + 1;
    else
        bool2 = 1;
    end
end

bool3 = 0;
while bool3==0
    testfile = strcat('../../test/testdata/TimelineSolution','C',num2str(testdataiterator(3)), '.dat');
    if exist(testfile, 'file') == 2
        testdataiterator(3) = testdataiterator(3) + 1;
    else
        bool3 = 1;
    end
end



difficulty='A';
difficulty_number = 1;

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
    'Position',[0.49 0.63 0.41 0.32]);

testdatagen    = uicontrol('Style','pushbutton',...
    'String','Create test data', 'Units','normalized','Position',[0.805,0.66,0.08,0.05],...
    'Callback',@testdatagen_callback);

testdataload    = uicontrol('Style','pushbutton',...
    'String','Load test data', 'Units','normalized','Position',[0.5,0.44,0.2,0.05],...
    'Callback',@testdataload_callback, ...
    'Enable','off');

    function testdataload_callback(source,eventdata)
        
    end

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
    'String','Save test data', 'Units','normalized','Position',[0.5,0.39,0.2,0.05],...
    'Callback',@testdatasave_callback);

    function testdatasave_callback(source,eventdata)
        UserFile1 = strcat('../../test/testdata/TimelineSolution', difficulty,num2str(testdataiterator(difficulty_number)), '.dat');
        UserFile2 = strcat('../../test/testdata/TimelineAttributes', difficulty,num2str(testdataiterator(difficulty_number)), '.dat');
        UserFile3 = strcat('../../test/testdata/DependencyMatrix', difficulty,num2str(testdataiterator(difficulty_number)), '.dat');
        UserFile4 = strcat('../../test/testdata/DependencyAttributes', difficulty,num2str(testdataiterator(difficulty_number)), '.dat');
        fil1 = [];
        fil2 = [];
        for it=1:length(TimelineSolution)
            fil1 = [fil1; TimelineSolution{it}, it*ones(size(TimelineSolution{it},1),1)];
            fil2 = [fil2; attributes{it}, it*ones(size(TimelineSolution{it},1),1)];
        end
        fil3 = DependencyMatrix;
        fil4 = DependencyAttribute;
        
        save(UserFile1, 'fil1', '-ascii')
        save(UserFile2, 'fil2', '-ascii')
        save(UserFile3, 'fil3', '-ascii')
        save(UserFile4, 'fil4', '-ascii')
        
        testdataiterator = testdataiterator+1;
    end

testresultsave    = uicontrol('Style','pushbutton',...
    'String','Save test results', 'Units','normalized','Position',[0.05,0.2,0.2,0.05],...
    'Callback',@testresultsave_callback,'Enable','off');

    function testresultsave_callback(source,eventdata)
        
    end

run_tabu    = uicontrol('Style','pushbutton',...
    'String','Run tabu search', 'Units','normalized','Position',[0.05,0.05,0.2,0.05],...
    'Callback',@run_tabu_callback, ...
    'Enable','off');

    function run_tabu_callback(source,eventdata)
        
    end

run_lns    = uicontrol('Style','pushbutton',...
    'String','Run large neighborhood search', 'Units','normalized','Position',[0.05,0.1,0.2,0.05],...
    'Callback',@run_lns_callback, ...
    'Enable','off');

    function run_lns_callback(source,eventdata)
        
    end

run_lp    = uicontrol('Style','pushbutton',...
    'String','Run MIP method', 'Units','normalized','Position',[0.05,0.15,0.2,0.05],...
    'Callback',@run_lp_callback, ...
    'Enable','off');

    function run_lp_callback(source,eventdata)
        
    end

% ha1 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.6,0.3,0.3]);

distribution_group = uibuttongroup(f,'Title','Dependency distribution',...
    'Position',[.5 .85 .20 .08]);

distribution2_group = uibuttongroup(f,'Title','Maximum time between dependent tasks',...
    'Position',[.5 .75 .20 .08]);

distribution3_group = uibuttongroup(f,'Title','Starting time and deadline distribution',...
    'Position',[.5 .65 .20 .08]);

level_selector = uibuttongroup(f,'Title','Data difficulty level',...
    'Position',[.5 .5 .20 .08]);

levela = uicontrol(level_selector,'Style','radiobutton','String','Level A',...
    'Units','normalized',...
    'Position',[.1 .3 .6 .4], ...
    'Callback',@lv1_callback, ...
    'Tag', 'rab1');

    function lv1_callback(source,eventdata)
        
    end

levelb = uicontrol(level_selector,'Style','radiobutton','String','Level B',...
    'Units','normalized',...
    'Position',[.4 .3 .6 .4], ...
    'Callback',@lv2_callback, ...
    'Tag', 'rab1');

    function lv2_callback(source,eventdata)
        
    end

levelc = uicontrol(level_selector,'Style','radiobutton','String','Level C',...
    'Units','normalized',...
    'Position',[.7 .3 .6 .4], ...
    'Callback',@lv3_callback, ...
    'Tag', 'rab1');

    function lv3_callback(source,eventdata)
        
    end

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

htext1  = uicontrol('Style','text','String','Spatial width:', 'Units','normalized',...
    'Position',[0.7,0.9,0.10,0.03]);

htext2  = uicontrol('Style','text','String','Spatial width:', 'Units','normalized',...
    'Position',[0.7,0.7,0.10,0.03]);

htext3  = uicontrol('Style','text','String','Spatial width:', 'Units','normalized',...
    'Position',[0.7,0.8,0.10,0.03]);

htext3  = uicontrol('Style','text','String','Sparseness:', 'Units','normalized',...
    'Position',[0.81,0.9,0.08,0.03]);

htext4  = uicontrol('Style','text','String','Level A data', 'Units','normalized',...
    'Position',[0.32,0.25,0.10,0.03]);

htext5  = uicontrol('Style','text','String','Level B data', 'Units','normalized',...
    'Position',[0.55,0.25,0.10,0.03]);

htext6  = uicontrol('Style','text','String','Level C data', 'Units','normalized',...
    'Position',[0.78,0.25,0.10,0.03]);
% txtbox1 = uicontrol('Style','edit',...
%     'String',num2str(12), 'Units','normalized',...
%     'Position',[0.735 0.82 0.03 0.02],...
%     'Callback',@txtbox1_callback);

uicontrol(f,'Style','slider',...
                'Min',0,'Max',100,'Value',25,...
                'SliderStep',[0.05 0.2], ...
                'Units','normalized',...
                'Position',[0.71 0.87 0.08 0.02]);
            
uicontrol(f,'Style','slider',...
                'Min',0,'Max',100,'Value',25,...
                'SliderStep',[0.05 0.2], ...
                'Units','normalized',...
                'Position',[0.81 0.87 0.08 0.02]);


uicontrol(f,'Style','slider',...
                'Min',0,'Max',100,'Value',25,...
                'SliderStep',[0.05 0.2], ...
                'Units','normalized',...
                'Position',[0.71 0.67 0.08 0.02]);

uicontrol(f,'Style','slider',...
                'Min',0,'Max',100,'Value',25,...
                'SliderStep',[0.05 0.2], ...
                'Units','normalized',...
                'Position',[0.71 0.77 0.08 0.02]);



lb1 = uicontrol(f,'Style','listbox',...
                'String',{'Test data 1','Test data 2','Test data 3','Test data 4'},...
                'Units','normalized',...
                'Position',[0.28 0.05 0.2 0.2],'Value',1);
            
lb2 = uicontrol(f,'Style','listbox',...
                'String',{'Test data 1','Test data 2','Test data 3','Test data 4'},...
                'Units','normalized',...
                'Position',[0.5 0.05 0.2 0.2],'Value',1, ...
                'Enable','off');
            
lb3 = uicontrol(f,'Style','listbox',...
                'String',{'Test data 1','Test data 2','Test data 3','Test data 4'},...
                'Units','normalized',...
                'Position',[0.72 0.05 0.2 0.2],'Value',1, ...
                'Enable','off');

    function distr1_callback(source,eventdata)
        
    end

    function distr2_callback(source,eventdata)
        
    end

    function distr3_callback(source,eventdata)
        
    end

    function distr4_callback(source,eventdata)
        
    end

    function distr5_callback(source,eventdata)
        
    end

    function distr6_callback(source,eventdata)
        
    end

    function testdatagen_callback(source,eventdata)
        
        set(checkbox,'Value',0);
        
        genlistoflen = @(listofstartingpoints,L) generatelistoflength(listofstartingpoints,L);
        genlistofstartpts = @(L, N) generatelistofstartingpoints(L, N);
        gentasks = @( Ntasks, Ntimelines ) generateNumberoftasksinTimelinevector( Ntasks, Ntimelines );
        attrgen_unif = @(TimelineSolution,L,variance,mu) Attributegenerator_uniform(TimelineSolution,L,variance,mu);
        gendepmatrix = @(TimelineSolution, Ndependencies, variance, mu) Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu);
        gendepattr = @(TimelineSolution,DependencyMatrix, variance, mu, L, N, T) Generatedependencyattributes(TimelineSolution,DependencyMatrix, variance, mu, L, N, T);
        
        % Hämta information från var knapparna befinner sig.
        TimelineSolution = [];
        attributes = [];
        DependencyMatrix = [];
        DependencyAttribute = [];
        
        
        [ TimelineSolution, attributes, DependencyMatrix, DependencyAttribute ] = Testdatagenerator(N, L, T, genlistoflen, ...
            genlistofstartpts,gentasks, attrgen_unif, ...
            gendepmatrix,gendepattr, Ndeps, 1, 1, 1, 1);
        
        
        
        % Måste konvertera lång Timelinesolution och attributes till
        % cell-array vid inläsning.
        
        % Visualisera testdata!!
        print_correct();
    end


% plot(1./(1:0.1:10));
% title('Rate of convergence vs iterations');
% xlabel('Number of iterations');
% ylabel('Objective function');







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
