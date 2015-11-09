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
%
%
% Linköping University, Linköping

status = 0;
PLOTALLMOVES = 1;

% Add timing:
tic

try
    % 1. Setup logging:
    [status, logfile] = GetLog(logfileParameters);
    % 2. Read data and data parameters:
    [status, data] = GetData(dataParameters,logfile);
    tabuParameters.nrTasks = size(data.tasks,2);
    
    % 3. Create result:
    [resultfile,runId] = CreateResult(resultParameters,logfile);
    
    % 4. Create model and all instances:
    model = CreateModel(tabuParameters,resultfile,logfile);
        
    % 5. Initial solution from model
    %[status,data] = InitialSolutionLauncher(model,data,logfile);   
    
	% 5. Initial figure ***DONE***
	if PLOTALLMOVES
		[top,bot_left,bot_right,figdata] = CreateFigures(data);
		DisplayIntervals(data,bot_left,figdata);
	end    


	% 6. Perform tabu 
	model.conditionsAreNotMet = 1;
	model.iterations = 1;

	while model.conditionsAreNotMet
	    try
            
            % 6.1 Get and do tabu action: This method also logs result:
            data = model.instance{model.activePhaseIterator}. ...
                instance.GetAndPerformAction(data);
            
			% 6.2 Display updated solution
            if PLOTALLMOVES
                DisplayCurrentSolution(data,top,figdata);
                cost(model.iterations) = model.instance{model.activePhaseIterator}. ...
                instance.GetCost();
                DisplayCostFunction(cost,bot_right,figdata);
                pause(0.1);
            end
            
            % 6.3 Evaluate current phase and over all conditions:
            model = model.instance{model.activePhaseIterator}. ...
                instance.GetStoppingCriteria(model);
            
            % 6.4 Evaluate if condation are met: *** NEEDS FIX!! *** NOT IN
            % INSTANCE.
            model = model.instance{model.activePhaseIterator}.instance.AreConditionsMet(model);
                        
            % End after X iterations
            nrIterations = 1000;
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
    close all;
    
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

% COSTPLOT:
% DEBUGPLOT=0;
% if DEBUGPLOT % false
%                 % 6.1.1 Print actionlist:
%                 figure(1);
%                 nlist = size(actionList,2);
%                 A = zeros(nlist,4);
%                 for i = 1:nlist
%                     % actionList{i}.cost
%                     A(i,1) = actionList{i}.cost.dep;
%                     A(i,2) = actionList{i}.cost.over;
%                     A(i,3) = actionList{i}.cost.bound;
%                     A(i,4) = actionList{i}.cost.total;
%                 end
% 
%                 plot(A)
%                 legend('dep','over','bound','total')
%                 pause(0.1)
%             end
