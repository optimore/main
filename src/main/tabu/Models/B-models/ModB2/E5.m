classdef E5 < handle
    % E5 Summary of this class goes here
    %
    %
    
    properties(GetAccess = 'public', SetAccess = 'private')
        
        Name
        TabuList
        Logfile
        Resultfile
        NrTasks
        Solution = 1;
        CostList
        ActionList
        IterationId=1;
        LowestCost = [0, inf];
        ActionSolution = [];
        MaxPhaseIterations
        NrOfBadIterationsBeforExit=5;
        % dep overlap bounds
        CostWeight = [5 1 1];
    end
    
%     properties(Constant = true)
% 
% 
% 
%     end
    
    methods
        % Create Tabu List
        function TabuList = CreateTabuList(obj)
            if(nargin > 0)
                try
                    listlength = 20;
                    TabuList = zeros(listlength,1);
                catch err
                    disp('error')
                    fprintf(obj.Logfile, getReport(err,'extended'));
                    TabuList=[];
                    rethrow(err);
                end
            end
        end
        
        % Constructor:
        function obj = E5(resultfile,logfile,nrTasks)
            name = class(obj);
            disp(['Running: ', num2str(name)])
            obj.Name = name;
            obj.NrTasks = nrTasks; % 8; % size(data.tasks,2)
            obj.Logfile = logfile;
            % Not used:
            % obj.MaxPhaseIterations = round(nrTasks/5);
            obj.Resultfile = resultfile;
            obj.TabuList = obj.CreateTabuList();
        end
        
        % Get Action list and do action
        function [data,obj] = GetAndPerformAction(obj,data,iterationId)
            % Iterate over and save posible solutions:
            try
                % Dynamic weights calculated
                if mod(iterationId,20) == 0
                    obj.SetWeights(data);
                end
                
                posibleTaskActions = [-1.5E8, -0.75E8, -4E7, -8E6, -4E5, 4E5, 8E6, 4E7, 0.75E8, 1.5E8];
                nrTasks = size(data.tasks,1);
                nrActions = length(posibleTaskActions);
                actionId = 1;
                
                % Create empty actionList and costList:
                actionList = struct('cost',{},'actionSolution',{});
                costList = zeros(nrActions*nrTasks,1);
                
                for i = 1:nrTasks
                    for ii = 1:nrActions
                        
                        % Find new solution:
                        % Copy all task positions
                        tempSolution = zeros(nrTasks,2);
                        tempSolution(:,1) = data.tasks(:,1);
                        tempSolution(:,2) = data.tasks(:,6);
                        % Move one solution
                        tempSolution(i,2) = tempSolution(i,2)+posibleTaskActions(ii);
                        
                        % Calculate cost *** Needs testing ***
                        action.cost = CostFunction(data,tempSolution,obj.CostWeight);
                        action.totalcost = action.cost.total;
                        action.actionSolution = tempSolution;
                        
                        % Save action to actionlist
                        actionList{actionId} = action;
                        costList(actionId) = action.totalcost;
                        
                        % Increase iterator
                        actionId = actionId + 1;
                    end
                end
            catch err
                fprintf(obj.Logfile, getReport(err,'extended'));
                rethrow(err)
            end
            
            %obj.CostList = costList;
            %obj.ActionList = actionList;
            
            % Do Action:
            try
                % =========== 1st version: Using solutions ================
                [sortedCosts, indexes] = sort(costList);
                
                % Loop through min-solutions in ascending order
                for i = 1:length(costList)
                    
                    notintabu = 1;
                    index = indexes(i);
                    actionSolution = actionList{index}.actionSolution(:,2);
                    
                    % Find changed task
                    currentSolution = data.tasks(:,6);
                    changedTask = find(actionSolution - currentSolution);
                    
                    % Compare solution with tabu list solutions
                     for j = 1:size(obj.TabuList,1)
                        tabuTask = obj.TabuList(j);
                        
                        % Break if action in tabulist
                        if isequal(tabuTask, changedTask) == 1
%                             disp(['Tabu hit!', obj.Name]);
                            if costList(index) < obj.LowestCost(2)
                                % Aspiration criteria
%                                 disp(['Asipiration criteria: ', obj.Name, ' tabu: ', ...
%                                     num2str(costList(index)),' cost: ', ...
%                                     num2str(obj.LowestCost(2))])    
                            else
                                notintabu = 0;
                                break;
                            end
                        end
                    end
                    
                    
                    if notintabu == 1
                        
                        % Add action to tabu list
                        obj.TabuList(2:end) = obj.TabuList(1:end-1);
                        obj.TabuList(1) = changedTask;
                        
                        
                        % Perform action
                        lowestCost = sortedCosts(i);
                        
                        % save cost list
                        obj.CostList(2:end) = obj.CostList(1:end-1);
                        obj.CostList(1) = lowestCost;
                        
                        data.tasks(:,6) = actionSolution;
                        
                        if lowestCost < obj.LowestCost(2)
                            obj.LowestCost = [obj.IterationId,lowestCost];
                        end
                        
                        obj.ActionSolution = actionSolution;
                        
                        % *** Add later ***
                        timenow = toc;
                        
                        % Log results
                        fprintf(obj.Resultfile, [num2str(iterationId),',',num2str(lowestCost),',',num2str(timenow),'\n']);
                        obj.IterationId = obj.IterationId + 1;
                        
                        break;
                    end
                    
                end

            catch err
                disp('ERROR in do action class')
                disp(err.stack)
                rethrow(err)
            end
        end
        
        % Get stopping criteria:
        function [model,obj] = GetStoppingCriteria(obj, model)
 
                % If solution getting worse
                
                if diff(obj.CostList)<=0
                    
%                 if  obj.LowestCost(1) < ...
%                         obj.IterationId - obj.NrOfBadIterationsBeforExit
%                     obj.IterationId = 0;
                    
                    % Old: obj.IterationId > round(obj.NrTasks/5) &&
        
                % Take next in phase order
                nrPhases = size(model.phases,2);
                model.activePhaseIterator= ...
                    mod(model.activePhaseIterator,nrPhases)+1;
                
                
%                 model.instance{model.activePhaseIterator}. ...
%                     instance.SetTabulistCost(obj.TabuList, ...
%                                              obj.LowestCost);
                end
        end
        
        function [obj] = SetTabulistCost(obj,tabulist, lowestcost)
            
            obj.TabuList = tabulist;
            obj.LowestCost = lowestcost;
            
        end
        
        function [model, obj] = AreConditionsMet(obj,model)
            try
                if obj.LowestCost(2)==0
                    model.conditionsAreNotMet = 0;
                end
            catch err
                rethrow(err)
            end
        end
        
        function [obj] = SetWeights(obj,data)
            
            curSolution = zeros(obj.NrTasks,2);
            curSolution(:,1) = data.tasks(:,1);
            curSolution(:,2) = data.tasks(:,6);
            
            costStruct = CostFunction(data,curSolution,obj.CostWeight);
            %costVec = [costStruct.total,costStruct.over,costStruct.dep,costStruct.bound];
            
            weightDep = max(0.01, costStruct.dep/costStruct.total);
            weightOver = max(0.01, costStruct.over/costStruct.total);
            weightBound = max(0.01, costStruct.bound/costStruct.total);
            
            obj.CostWeight = [weightDep, weightOver, weightBound];
        end
        
        function [costVec, obj] = GetCost(obj,data)
            % cost = obj.LowestCost(2);
            
            curSolution = zeros(obj.NrTasks,2);
            curSolution(:,1) = data.tasks(:,1);
            curSolution(:,2) = data.tasks(:,6);
            
            costStruct = CostFunction(data,curSolution,obj.CostWeight);
            costVec = [costStruct.total,costStruct.over,costStruct.dep,costStruct.bound];
        end
    end
end

%%