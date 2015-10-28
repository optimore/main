function statuscode = tabumain(dataPath,modelParameters)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% 
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01

% Linköping University, Linköping

% 1. Create model
model = CombindModelsFromParameters(modelParameters)

% 2. Starting condition from model

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