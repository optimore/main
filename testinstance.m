%% Instance script:
clc; clear all;

addpath(genpath('src/main/tabu'));

logParameters.path = 'target/logs/log_test';
dataParameters.path = 'src/test/testdata/A2_2015-10-30T15-14-12/';
resultParameters.path = 'target/results/results_test';
resultParameters.id = 1;
modelParameters = struct( ...
    'tabu', struct('active',1,'initial',1,'phases',[1]), ...
    'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
    'ampl', struct('active',0,'initial',1,'phases',[1]));


logfile = GetLog(logParameters);
data=GetData(dataParameters,logfile);
tabuParameters=modelParameters.tabu;
tabuParameters.nrTasks = size(data.tasks,2);

[resultfile,runId] = CreateResult(resultParameters,logfile);
%%

model = CreateModel(tabuParameters,resultfile,logfile);
model.instance{1}.instance

model.instance{model.activePhase}


%%

nrTasks = size(data.tasks,1);
% instance = SimpleMoveOneTask(resultfile,logfile,nrTasks);
%data = instance.SetStartingSolution(data);

%%
data = instance.GetAndPerformAction(data);
data.tasks(:,6)

%%
rmpath(genpath('src/main/tabu'));

close('all')




%%
clc
A = [ 1 2 3 4 ];
for i = A; 
    switch i
        case 1,
            disp('A = 1')
        case 2,
            disp('A = 2')
        otherwise
            disp('unknown')
    end
end
    
    