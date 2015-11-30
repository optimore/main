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
% Link?ping University, Link?ping

nrTasks = tabuParameters.nrTasks;

model.initialSolution = tabuParameters.initial;

model.phaseChanges = [];

model.phases = tabuParameters.phases;
model.activePhaseIterator = 1;

instanceIterator = 1;
try
    model.instance = struct('name',{},'id',{},'instance',{});
    for inst = model.phases
        switch inst
            case 1,
                instance.name = 'E1';
                instance.instance = E1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 2,
                instance.name = 'E2';
                instance.instance = E2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 3,
                instance.name = 'E3';
                instance.instance = E3(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 4,
                instance.name = 'E4';
                instance.instance = E4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 5,
                instance.name = 'E5';
                instance.instance = E5(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 6,
                instance.name = 'E6';
                instance.instance = E6(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 101,
                instance.name = 'C1_1';
                instance.instance = C1_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 102,
                instance.name = 'C1_2';
                instance.instance = C1_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 103,
                instance.name = 'C1_3';
                instance.instance = C1_3(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 104,
                instance.name = 'C1_4';
                instance.instance = C1_4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 105,
                instance.name = 'C1_5';
                instance.instance = C1_5(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 106,
                instance.name = 'C1_6';
                instance.instance = C1_6(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 201,
                instance.name = 'C2_1';
                instance.instance = C2_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            %case *,
                
            otherwise,
                disp(['instance ', num2str(inst), ' not active.'])
        end
        instanceIterator = instanceIterator + 1;
    end
catch err
    rethrow(err)
end