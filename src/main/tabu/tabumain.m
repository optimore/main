function status = tabumain(dataParameters, tabuParameters, logfileParameters, resultParameters)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% 
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01
% 0.02: better structure and always run with status 1
%
%
% Linköping University, Linköping

DEBUGPLOT=1;

status = 0;

% Add timing:
tic

try
    % 1. Setup logging *** DONE ***
    logfile = GetLog(logfileParameters);
    % logfile.parameters = logfileParameters;
    
    % 2. Read data and data parameters *** DONE ***
    data = GetData(dataParameters,logfile);
    data.parameters = dataParameters;
    
    % 3. Create model *** DONE ***
    model = CreateModel(tabuParameters,logfile);
    model.parameters = tabuParameters;
    
    % 4. Create result *** NEED IMPLEMENTATION ***
    result = CreateResult(resultParameters,logfile);
    result.parameters = resultParameters;
    
    % 5. Initial solution from model *** DONE ***
    [status,data] = InitialSolutionLauncher(model,data,logfile);   
    
    % 6. Initiate tabu list from model *** NEED IMPLEMENTATION ***
    [status, tabuList] = CreateTabuList(model, data);
    
    % 6. Perform tabu *** NEED IMPLEMENTATION ***
    conditionsAreNotMet = 1;
    iterations = 1;
    while conditionsAreNotMet
        try
            
            % 6.1 Get actions in list with costs associated:
            [status,actionList,costList] = GetActionList(model,data,tabuList,logfile);
            
            if DEBUGPLOT
                % 6.1.1 Print actionlist:
                figure(1);
                nlist = size(actionList,2);
                A = zeros(nlist,4);
                for i = 1:nlist
                    % actionList{i}.cost
                    A(i,1) = actionList{i}.cost.dep;
                    A(i,2) = actionList{i}.cost.over;
                    A(i,3) = actionList{i}.cost.bound;
                    A(i,4) = actionList{i}.cost.total;
                end

                plot(A)
                legend('dep','over','bound','total')
                pause(0.1)
            end
            
            % 6.2 Iteration logging
            fprintf(logfile, ['Iteration nr: ', num2str(iterations), '. ']);
            [status, data, tabuList] = DoAction(model,data,actionList,costList,tabuList,logfile);
            
           
            % Evaluate current phase:
            % model = EvaluateNextStep(model,data);

            % Evaluate if condation are met:
            [status, conditionsAreNotMet] = AreConditionsMet(costList);
            
            iterations = iterations + 1;

            % End after 100 iterations
            if iterations > 100
                disp('Search ended after 100 iterations, no solution found.');
                conditionsAreNotMet=0;
            end
            
        catch err
            fprintf(logfile,'\n\nFatal error in tabu search, quiting search\n')
            rethrow(err);
        end
    end
    
    
    % . If all was successful, then set statuscode to 1
    status = 1;
    
    fprintf(logfile, ['Tabu search finished successfully.\nClosing log: ', ... 
        datestr(now()), '\n---------------------------------------\n']);
    fclose('all');
    
catch err
    % In case of an error, set statuscode to -1
    status = -1;
    fprintf(logfile, getReport(err,'extended'));
    fprintf(logfile, ['\nClosing tabu-log due to fatal error: ', ... 
        datestr(now()), '\n---------------------------------------\n']);
    fclose('all');
end

toc



end



% Catch user quit

% Målfunktion / tid, ta varje sekund
