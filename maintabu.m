clc;

% This funcion is in guitest
% logPath = CreateLog()

% Old: dataParameters.path = 'src/test/testdata/firsttestdataexampel.dat';
dataParameters.path = 'src/test/testdata/TimelineAttributes1.dat';
modelParameters.tabu = {[1,2,3]};
logParameters.path = 'target/logs/2015-10-28T14-15-31.log';
logParameters.id = 1;
resultParameters.path = 'target/results/resultPath/';

addpath 'src/main/tabu';
runstatus = tabumain(dataParameters,modelParameters{1},logParameters,resultParameters)
rmpath 'src/main/tabu';
