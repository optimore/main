clc;

% This funcion is in guitest
% logPath = CreateLog()

% Old: dataParameters.path = 'src/test/testdata/firsttestdataexampel.dat';
dataParameters = struct('path','src/test/testdata/A1_2015-10-30T11-14-11/');
modelParameters = struct( ...
    'tabu', struct('initial',1,'phases',[1]), ...
    'LNS' , struct('initial',1,'phases',[1]), ...
    'ampl', struct('initial',1,'phases',[1]));
logfileParameters = struct('path','target/logs/2015-10-28T14-15-31.log','id',1);
resultParameters = struct('path','target/results/resultPath/');

addpath(genpath('src/main/tabu')); %'src/main/tabu';
runstatus = tabumain(dataParameters,modelParameters.tabu,logfileParameters,resultParameters)
rmpath(genpath('src/main/tabu')); % 'src/main/tabu';
