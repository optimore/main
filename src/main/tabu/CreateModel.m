function model=CreateModel(tabuParameters,resultfile,logfile)
%% Combind models from parameters
% This function creates a model from given parameters
% Created by: Victor Bergelin
% Date created: 28/10/2015
%
% Version number 
% 0.03: has everything but error handling, still needed!
% 0.02: minor development, not tested
% 0.01: file setup
%
% Linköping University, Linköping

nrTasks = tabuParameters.nrTasks;

model.initialSolution = tabuParameters.initial;

model.phases = tabuParameters.phases;
model.activePhaseIterator = 1;

try
    model.instance = struct('name',{},'id',{},'instance',{});
    for inst = model.phases
        switch inst
            case 1,
                instance.name = 'SimpleMoveOneTask';
                instance.instance = SimpleMoveOneTask(resultfile,logfile,nrTasks);
                model.instance{1} = instance;
            %case 2,
            otherwise,
                disp(['instance ', num2str(inst), ' not active.'])
        end
    end
catch err
    rethrow(err)
end