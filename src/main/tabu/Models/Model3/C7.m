classdef C7 < handle
    %C4 Summary of this class goes here
    %   
    % 
    
    properties(GetAccess = 'public', SetAccess = 'private')
        TabuList
        Logfile 
        Resultfile
        NrTasks
        Solution = 1;
        CostList
        ActionList
        IterationId=1;
        LowestCost = Inf;
        ActionSolution = [];
        MaxPhaseIterations
    end
    
    properties(Constant = true)
        CostWeight = [1.1 1.2 3];
    end
    
    methods        
        % Create Tabu List
        function TabuList = CreateTabuList(obj)
            if(nargin > 0)
                try
                    listlength = 100;
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
        function obj = C7(resultfile,logfile,nrTasks)
            disp('Running C7')
            obj.NrTasks = nrTasks;
            obj.MaxPhaseIterations = round(nrTasks/5);
            obj.Logfile = logfile;
            obj.Resultfile = resultfile;
            obj.TabuList = obj.CreateTabuList();
        end 
        
        % Get Action list and do action
        function [data,obj] = GetAndPerformAction(obj,data)
            % Iterate over and save posible solutions:
            try
                posibleTaskActions = [-5E6,-1E4,1E4,5E6];
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
                            notintabu = 0;
                            break;
                        end
                    end


                    if notintabu == 1

                        % Add action to tabu list
                        actioncell = num2cell(actionSolution, 1);
                        obj.TabuList(2:end) = obj.TabuList(1:end-1);
                        obj.TabuList(1) = actioncell;


                        % Perform action
                        lowestCost = sortedCosts(i);
                        
                        data.tasks(:,6) = actionSolution;

                        obj.LowestCost = lowestCost;
                        obj.ActionSolution = actionSolution;
                        
                        % *** Add later *** 
                        timenow = toc;
                        
                        % Log results
                        fprintf(obj.Resultfile, [num2str(obj.IterationId),',',num2str(lowestCost),',',num2str(timenow),'\n']);
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
            if obj.IterationId > obj.MaxPhaseIterations
                obj.IterationId = 0;
                
                % Recreate model when phase is over and set next phase:
                instance.instance = C4(obj.Resultfile,obj.Logfile,obj.NrTasks);
                model.instance{model.activePhaseIterator} = struct();
                model.instance{model.activePhaseIterator} = instance;

                % Take next in phase order
                nrPhases = size(model.phases,2);
                model.activePhaseIterator= ...
                    mod(model.activePhaseIterator,nrPhases)+1;
                
            end
        end
        
        function [model, obj] = AreConditionsMet(obj,model)
            try
                if obj.LowestCost==0
                    model.conditionsAreNotMet = 0;
                end
            catch err
                rethrow(err)   
            end
        end
        
        function [cost, obj] = GetCost(obj)
            cost = obj.LowestCost;
        end
    end
end

