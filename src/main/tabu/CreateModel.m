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
    iterator = 1;
    for inst = model.phases
        switch inst
            case 1,
                instance.name = 'SimpleMoveOneTask';
                instance.instance = SimpleMoveOneTask(resultfile,logfile,nrTasks);
                model.instance{iterator} = instance;
            case 2,
                instance.name = 'SMOT_TabuListTasks_2';
                instance.instance = SMOT_TabuListTasks_2(resultfile,logfile,nrTasks);
                model.instance{iterator} = instance;
            otherwise,
                disp(['instance ', num2str(inst), ' not active.'])
        end
        iterator = iterator + 1;
    end
catch err
    rethrow(err)
end