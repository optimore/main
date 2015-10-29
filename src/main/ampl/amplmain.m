function statuscode = tabumain(dataParameters, modelParameters, logParameters, resultParameters)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% 
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01

% Linköping University, Linköping

statuscode = 0;

try
    % 1. Setup logging
    logfile = GetLog(logParameters.path);

    % 2. Read data and data parameters
    data = GetData(dataParameters);

    % data now contains:
    % data.data
    % data.parameters
    
    % 3. Create model
    model = CombindModelsFromParameters(modelParameters,data.parameters);

    % 4. Starting condition from model
    data = StartingCondition(model,data);
    
    % 5. Perform tabu
    conditionsAreNotMet = 1;
    while conditionsAreNotMet
        try
            model.actionList = GetActionList(model,data);
            data = DoAction(model,data);

            % Evaluate current phase:
            model = EvaluateNextStep(model,data);

            % Evaluate if condation are met:
            model.conditionsAreMet = AreConditionsMet(data)
            
            
            if model.conditionAreMet
                conditionsAreNotMet = 0;
            end
        catch err
           % fprintf(logfile,[err.stack,'\n'])
            rethrow(err);
        end
    end
    
    
    % . If all was successful, then set statuscode to 1
    statuscode = 1;
    
catch err
    % In case of an error, set statuscode to -1
    statuscode = -1;
    disp(err.stack)
    fprintf(logfile,['Error in: ', err.stack.name, '\nFile: ', ... 
        err.stack.file, '\nLine: ', int2str(err.stack.line), ... 
        '\nClosing tabu-log due to fatal error', ... 
        '\n-------------------------------\n']);
    
    fclose('all');
end
end