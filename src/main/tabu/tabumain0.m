function status = tabumain(dataParameters, tabuParameters, logfileParameters, resultParameters)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% TODO: 
% - Catch user force-quit and handle abort!
% - Set next phase in object instance, recreate model when phase is over
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01
% 0.02: better structure and always run with status 1
% 0.03: OOD on instances to better handle multiple models and methods
% 1.0: Stable for running tabu searches on a variety of data and models
%
% Link?ping University, Link?ping

status = 0;

% Tabu run setup
% End after X iterations
nrIterations = 1500;
sleeptime = 0.01;
PLOTON = 0;
PLOTSOL = 0;
FINALPLOTON = 0;

% Add timing:
tic

try
    % 1. Setup logging:
    [status, logfile] = GetLog(logfileParameters);

    % 2. Read data and data parameters:
    [status, data] = GetData(dataParameters,logfile);
    tabuParameters.nrTasks = size(data.tasks,1);
    tabuParameters.nrTimels = max(data.tasks(:,4));
    tabuParameters.nrDeps = size(data.dependencies,1);
    
    % 3. Create result:
    [resultfile,runId] = CreateResult(resultParameters,dataParameters,logfile);
    
    % 4. Create model and all instances:
    model = CreateModel(tabuParameters,resultfile,logfile);
        
    % 5. Initial solution from model
    [status,data] = InitialSolutionLauncher(model,data,logfile);   
    
	% 5. Initial figure ***DONE***
	if PLOTON
		titlename = 'NOT in use'; %strsplit(dataParameters.name(1:3),'_');
        titlestr = {char(titlename), ...
                    num2str(tabuParameters.nrTasks), ...
                    num2str(tabuParameters.nrTimels), ...
                    num2str(tabuParameters.nrDeps), ...
                    mat2str(model.phases)};
        
        [top,bot_left,bot_right,figdata] = CreateFigures(data,titlestr);
		DisplayIntervals(data,bot_left,figdata);
	end    


	% 6. Perform tabu 
	model.conditionsAreNotMet = 1;
	model.iterations = 1;
    cost = [0,0,0,0];
    
	while model.conditionsAreNotMet
	    try

            % 6.1 Get and do tabu action: This method also logs result:
            data = model.instance{model.activePhaseIterator}. ...
                instance.GetAndPerformAction(data, model.iterations);
            
            % Save costs
            if model.iterations == 1
                cost = model.instance{model.activePhaseIterator}. ...
                    instance.GetCost(data);
            else
                cost = [cost; model.instance{model.activePhaseIterator}. ...
                    instance.GetCost(data)];
            end
            
            % 6.2 Display updated solution
            if PLOTON
                if PLOTSOL || model.iterations == 1
                    DisplayCurrentSolution(data,top,figdata);
                end
                pause(sleeptime);
                
                figdata.iteration = model.iterations;
                figdata.phase = [num2str(model.activePhaseIterator),' (', ...
                    model.instance{model.activePhaseIterator}.name,')'];
                DisplayCostFunction(cost,bot_right,figdata);
                
            end
            
            % 6.3 Evaluate current phase and phase change:
            model = model.instance{model.activePhaseIterator}. ...
                instance.GetStoppingCriteria(model);
            
            % 6.4 Evaluate if condation are met: 
            model = model.instance{model.activePhaseIterator}.instance.AreConditionsMet(model);
            
            if model.iterations > nrIterations
                model.conditionsAreNotMet=0;
            end
            
            
        catch err
            fprintf(logfile,'\n\nFatal error in tabu search, quiting search\n')
            rethrow(err);
        end
        model.iterations = model.iterations + 1;
    end
    
    %Close figures
    % close all;
    
    % Final plot
    if FINALPLOTON
        figdata.iteration = model.iterations;
        figdata.phase = [num2str(model.activePhaseIterator),' (', ...
            model.instance{model.activePhaseIterator}.name,')'];
        DisplayCostFunction(cost,bot_right,figdata);
    end
    
    % . If all was successful, then set statuscode to 1
    status = 1;
    
    fprintf(logfile, ['Tabu search finished successfully.\nClosing log: ', ...
        datestr(now()), '\n---------------------------------------\n']);
    
    % Close files:
    fclose(resultfile);
    fclose(logfile);
    
catch err
    % In case of an error, set statuscode to -1
    status = -1;
    fprintf(logfile, getReport(err,'extended'));
    fprintf(logfile, ['\nClosing tabu-log due to fatal error: ', ...
        datestr(now()), '\n---------------------------------------\n']);
    fclose('all');
end

closetime = toc;


end