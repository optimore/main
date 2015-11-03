function statuscode = tabumain(dataParameters, tabuParameters, logfileParameters, resultParameters)
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

statuscode = 0;

% Add temporary paths
% addpath 'src/main/tabu/InitialSolutions';
% addpath 'src/main/tabu/Instances';

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
    status = InitialSolutionLauncher(model,data,logfile);   
    
    % 6. Initiate tabu list from model *** NEED IMPLEMENTATION ***
    tabuList = CreateTabuList(model);
    
    % 6. Perform tabu *** NEED IMPLEMENTATION ***
    conditionsAreNotMet = 1;
    while conditionsAreNotMet
        try
            actionList = GetActionList(model,data,tabuList,logfile);
            data = DoAction(model,data,actionList,logfile);
            
            % Evaluate current phase:
            % model = EvaluateNextStep(model,data);

            % Evaluate if condation are met:
            % model.conditionsAreMet = AreConditionsMet(data)
            
            model.conditionAreMet = 1;
            if model.conditionAreMet
                conditionsAreNotMet = 0;
            end
        catch err
            fprintf(logfile,'\n\nFatal error in tabu search, quiting search\n')
            rethrow(err);
        end
    end
    
    
    % . If all was successful, then set statuscode to 1
    statuscode = 1;
    
    fprintf(logfile, ['Tabu search finished successfully.\nClosing log: ', ... 
        datestr(now()), '\n---------------------------------------\n']);
    fclose('all');
    
catch err
    % In case of an error, set statuscode to -1
    statuscode = -1;
    fprintf(logfile, getReport(err,'extended'));
    fprintf(logfile, ['\nClosing tabu-log due to fatal error: ', ... 
        datestr(now()), '\n---------------------------------------\n']);
    fclose('all');
end

% Remove temporary paths:
% rmpath 'src/main/tabu/InitialSolutions';
% rmpath 'src/main/tabu/Instances';

end
