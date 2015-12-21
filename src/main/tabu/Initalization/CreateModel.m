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
% 1.0: Stable for running tabu searches on a variety of data and models
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
                instance.name = 'E4';
                instance.instance = E4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 2,
                instance.name = 'E5';
                instance.instance = E5(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 3,
                instance.name = 'MA_1';
                instance.instance = MA_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 4,
                instance.name = 'MA_2';
                instance.instance = MA_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 5,
                instance.name = 'MB_1';
                instance.instance = MB_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 6,
                instance.name = 'MB_2';
                instance.instance = MB_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 7,
                instance.name = 'MC_1';
                instance.instance = MC_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 8,
                instance.name = 'MC_2';
                instance.instance = MC_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 9,
                instance.name = 'MD_1';
                instance.instance = MD_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 10,
                instance.name = 'MD_2';
                instance.instance = MD_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 11,
                instance.name = 'MD_3';
                instance.instance = MD_3(resultfile,logfile,nrTasks);
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
            case 107,
                instance.name = 'C1_7';
                instance.instance = C1_7(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 108,
                instance.name = 'C1_8';
                instance.instance = C1_8(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 109,
                instance.name = 'C1_9';
                instance.instance = C1_9(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 110,
                instance.name = 'C1_10';
                instance.instance = C1_10(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 201,
                instance.name = 'C2_1';
                instance.instance = C2_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 202,
                instance.name = 'C2_2';
                instance.instance = C2_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 301,
                instance.name = 'C3_1';
                instance.instance = C3_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 302,
                instance.name = 'C3_2';
                instance.instance = C3_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 303,
                instance.name = 'C3_3';
                instance.instance = C3_3(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 304,
                instance.name = 'C3_4';
                instance.instance = C3_4(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 305,
                instance.name = 'C2_1';
                instance.instance = C2_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 401,
                instance.name = 'C4_1';
                instance.instance = C4_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 402,
                instance.name = 'C4_2';
                instance.instance = C4_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 403,
                instance.name = 'C4_10';
                instance.instance = C4_10(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 404,
                instance.name = 'C4_20';
                instance.instance = C4_20(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 601,
                instance.name = 'C6_1';
                instance.instance = C6_1(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 602,
                instance.name = 'C6_2';
                instance.instance = C6_2(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 603,
                instance.name = 'C6_10';
                instance.instance = C6_10(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 604,
                instance.name = 'C6_20';
                instance.instance = C6_20(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 605,
                instance.name = 'C6_100';
                instance.instance = C6_100(resultfile,logfile,nrTasks);
                model.instance{instanceIterator} = instance;
            case 606,
                instance.name = 'C6_200';
                instance.instance = C6_200(resultfile,logfile,nrTasks);
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