%% Instance script:
clc; clear all;

addpath(genpath('src/main/tabu'));

logParameters.path = 'target/logs/log_test';
dataParameters.path = 'src/test/testdata/A2_2015-10-30T15-14-12/';
resultParameters.path = 'target/results/results_test';
resultParameters.id = 1;

logfile = GetLog(logParameters);
data=GetData(dataParameters,logfile);
[resultfile,runId] = CreateResult(resultParameters,logfile);

%%

nrTasks = size(data.tasks,1);
instance = SimpleMoveOneTaskC(resultfile,logfile,nrTasks);
data = instance.SetStartingSolution(data);

%%
data = instance.GetAndPerformAction(data);
data.tasks(:,6)

%%
rmpath(genpath('src/main/tabu'));

close('all')