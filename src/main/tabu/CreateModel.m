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
            case 7,
                instance.name = 'E7';
                instance.instance = E7(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 101,
                instance.name = 'V1';
                instance.instance = V1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 102,
                instance.name = 'V2';
                instance.instance = V2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 103,
                instance.name = 'V3';
                instance.instance = V3(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 104,
                instance.name = 'V4';
                instance.instance = V4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 105,
                instance.name = 'V5';
                instance.instance = V5(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 106,
                instance.name = 'V6';
                instance.instance = V6(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 107,
                instance.name = 'V7';
                instance.instance = V7(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 108,
                instance.name = 'V8';
                instance.instance = V8(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 109,
                instance.name = 'V9';
                instance.instance = V9(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 110,
                instance.name = 'V10';
                instance.instance = V10(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 111,
                instance.name = 'V11';
                instance.instance = V11(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 112,
                instance.name = 'V12';
                instance.instance = V12(resultfile,logfile,nrTasks);
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