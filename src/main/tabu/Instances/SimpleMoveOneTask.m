function actionList = SimpleMoveOneTask(data, logfile)
%% Phase instance 1 in tabu search
% This instance will move one task with different step length eatch iteration
% The stoping criteria is costfunction = 0
%
% version nr:
% 0.01: initial testing with -10, -1, 1, 10 steps
%

% 1. create empty actionList:
actionList = struct('cost',{},'actionSolution',{});

% 2. Setup the instance with parameters. Add more variables here if needed:
% this is unique for every instance type
weights = [1,1,1];
posibleTaskActions = [-400, -100, -1, 1, 100, 400];

% 3. Iterate over and save posible solutions:
try    
    nrTasks = size(data.tasks,1);
    nrActions = length(posibleTaskActions);
    actionId = 1;
    
    for i = 1:nrTasks
        for ii = 1:nrActions
            % 3.1 Find new solution:
            % Copy all task positions
            tempSolution = zeros(nrTasks,2);
            tempSolution(:,1) = data.tasks(:,1);
            tempSolution(:,2) = data.tasks(:,6);
            % Move one solution
            tempSolution(i,2) = tempSolution(i,2)+posibleTaskActions(ii);
            
            % Calculate cost *** Needs testing ***
            action.cost = CostFunction(data,tempSolution,weights);
            action.totalcost = action.cost.total;
            action.actionSolution = tempSolution;
            
            % Save action to actionlist
            actionList{actionId} = action;
            
            % Increase iterator
            actionId = actionId + 1;
        end
    end
catch err
    fprintf(logfile, getReport(err,'extended')); 
    rethrow(err)
end

end

