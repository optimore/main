function statuscode = tabumain(dataPath,modelParameters,logPath)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% 
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01

% Link�ping University, Link�ping


% dataPath = '/edu/vicbe348/Repo/optimore/guitest/src/test';


% . Setup logging

logfile = GetLog(logPath)

% . Read data and data parameters
data = GetData(dataPath);

% . Create model
model = CombindModelsFromParameters(modelParameters,data.parameters);

% . Starting condition from model

model.start




CostFunction
CombindModelsFromParameters
DoAction
CreateActionList

ModelSelection


---
DoInsertion
DoReversion
DoSwap

end