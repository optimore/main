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

instanceIterator = 1;
try
    model.instance = struct('name',{},'id',{},'instance',{});
    for inst = model.phases
        switch inst
            case 1,
                instance.name = 'C1';
                instance.instance = C1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 2,
                instance.name = 'C2';
                instance.instance = C2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 3,
                instance.name = 'C3';
                instance.instance = C3(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 4,
                instance.name = 'C4';
                instance.instance = C4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            otherwise,
                disp(['instance ', num2str(inst), ' not active.'])
        end
        instanceIterator = instanceIterator + 1;
    end
catch err
    rethrow(err)
end