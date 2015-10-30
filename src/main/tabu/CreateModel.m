function model=CreateModel(tabuParameters)
%% Combind models from parameters
% This function creates a model from given parameters
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: minor development, not tested
% 0.01: file setup
% Linköping University, Linköping

model.initialSolution = tabuParameters.initial;

model.phases = tabuParameters.phases;
model.activePhase = model.phases(1);

end