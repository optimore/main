classdef E3 < handle
    % E3 Summary of this class goes here
    %   
    % 
    
    properties(GetAccess = 'public', SetAccess = 'private')
        
        Last2Costs = [inf inf-5]
        Diff = inf
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
        NrOfBadIterationsBeforExit=2;
    end
    
    properties(Constant = true)
        % dep overlap bounds
        CostWeight = [5 1 1];
    end
    
    methods        
        % Create Tabu List
        function TabuList = CreateTabuList(obj)
            if(nargin > 0)
                try
                    listlength = round(obj.NrTasks/10);
                    tabucell = cell(1,obj.NrTasks);
                    TabuList = cell([size(tabucell) listlength]);
                catch err
                    disp('error')
                    fprintf(obj.Logfile, getReport(err,'extended'));
                    TabuList=[];
                    rethrow(err);
                end
            end
        end  
        
        % Constructor:
        function obj = E3(resultfile,logfile,nrTasks)
            name = class(obj);
            disp(['Running: ', num2str(name)])
            obj.Name = name;
            obj.NrTasks = nrTasks; % 8; % size(data.tasks,2)
            obj.Logfile = logfile;
            % Not used:
            obj.MaxPhaseIterations = round(nrTasks/5);
            obj.Resultfile = resultfile;
            obj.TabuList = obj.CreateTabuList();
        end 
        
        % Get Action list and do action
        function [data,obj] = GetAndPerformAction(obj,data,iterationId)
            % Iterate over and save posible solutions:
            try
                posibleTaskActions = [-1E4, -5E3, 5E3, 1E4];
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
            
            obj.CostList = costList;
            obj.ActionList = actionList;
                        
            % Do Action:
            try
                % =========== 1st version: Using solutions ================
                [sortedCosts, indexes] = sort(costList);

                % Loop through min-solutions in ascending order
                for i = 1:length(costList)

                    notintabu = 1;
                    index = indexes(i);
                    actionSolution = actionList{index}.actionSolution(:,2);

                    % Compare solution with tabu list solutions
                    for j = 1:length(obj.TabuList)
                        tabuSolution = obj.TabuList{j};


                        % Break if action in tabulist
                        if isequal(tabuSolution, actionSolution) == 1
                            if costList(index) > obj.LowestCost(2)
                                % Aspiration criteria
                                disp(['Asipiration criteria: ', obj.Name, ' tabu: ', ...
                                    num2str(costList(index)),' cost: ', ...
                                    num2str(obj.LowestCost(2))])
                                
                            else
                                notintabu = 0;
                                break;
                            end
                        end
                    end


                    if notintabu == 1

                        % Add action to tabu list
                        actioncell = num2cell(actionSolution, 1);
                        obj.TabuList(2:end) = obj.TabuList(1:end-1);
                        obj.TabuList(1) = actioncell;
                        
                        if mod(obj.IterationId,5) == 0
                            obj.Last2Costs = [obj.Last2Costs(2) costList(index)];
                            obj.Diff = obj.Last2Costs(1) - obj.Last2Costs(2);
                        end
                            %disp(['Diff: ', num2str(obj.Diff)]);
                        
                        % Perform action
                        lowestCost = sortedCosts(i);
                        
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
            
            
            % If solution getting worse - go to next phase
            if obj.LowestCost(1) < ... 
                    obj.IterationId-obj.NrOfBadIterationsBeforExit
                
                % Recreate tabu when phase is over and set next phase:
                obj.TabuList = obj.CreateTabuList();
                obj.LowestCost = [0, inf];
                obj.IterationId = 1;
                
                % Take next in phase order
                nrPhases = size(model.phases,2);
                model.activePhaseIterator= ...
                    mod(model.activePhaseIterator,nrPhases)+1;
                
            % If progress too slow - go to top phase
            elseif obj.Diff < 1E13
                
                disp(' ============ Progress too slow! ======== ')
                obj.Last2Costs = [inf 0];
                obj.Diff = inf;
                
                % Recreate tabu when phase is over and set next phase:
                obj.TabuList = obj.CreateTabuList();
                obj.LowestCost = [0, inf];
                obj.IterationId = 1;
                
                % Take top phase
                nrPhases = size(model.phases,2);
                model.activePhaseIterator= 1;
                
                
            end
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