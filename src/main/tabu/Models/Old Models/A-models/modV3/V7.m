classdef V7 < handle
    % V7 Summary of this class goes here
    % This class uses one task tabu list!
    % 
    % By: Victor Bergelin
    
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
        NrOfBadIterationsBeforExit=2;
    end
    
    properties(Constant = true)
        CostWeight = [6 1 1];
    end
    
    methods        
        % Create Tabu List for only moving one task
        function TabuList = CreateTabuList(obj)
            if(nargin > 0)
                try
                    obj.NrTasks
                    listlength = round(obj.NrTasks);
                    %tabucell = cell(1,obj.NrTasks);
                    %TabuList = cell([size(tabucell) listlength]);
                    TabuList = zeros(obj.NrTasks, listlength);
                catch err
                    disp('error')
                    fprintf(obj.Logfile, getReport(err,'extended'));
                    TabuList=[];
                    rethrow(err);
                end
            end
        end  
        
        % Constructor:
        function obj = V7(resultfile,logfile,nrTasks)
            name=class(obj);
            obj.Name = name;
            disp(['Running ',name])
            obj.NrTasks = nrTasks;
            obj.Logfile = logfile;
            obj.MaxPhaseIterations = round(nrTasks/3);
            obj.Resultfile = resultfile;
            obj.TabuList = obj.CreateTabuList();
        end 
        
        % Get Action list and do action
        function [data,obj] = GetAndPerformAction(obj,data,iterationId)
            % Iterate over and save posible solutions:
            try
                posibleTaskActions = [-1.5E8, -0.75E8, 0.75E8 1.5E8];
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
                [sortedCosts, indexes] = sort(costList);

                % Loop through min-solutions in ascending order
                for i = 1:length(costList)

                    notintabu = 1;
                    index = indexes(i);
                    actionSolution = actionList{index}.actionSolution(:,2);
 
                    
                    % V7 find changed solution:
                    currentSolution = data.tasks(:,6);
                    changedTask = find(actionSolution - currentSolution);
                   
                    % Compare solution with tabu list solutions
                    for j = 1:length(obj.TabuList)
                        length(obj.TabuList)
                        % size(obj.TabuList)
                        j
                        tabuTask = obj.TabuList(:,j);
                        
                        % Break if action in tabulist
                        if isequal(tabuTask, changedTask) == 1
                            if costList(index) < obj.LowestCost(2)
                                % Aspiration criteria
                                disp(['Asipiration criteria V7, solution: ', ...
                                    num2str(costList(index)),' lowestEver: ', ...
                                    num2str(obj.LowestCost(2))])
                                notintabu = 1;
                            else
                                notintabu = 0;
                                break;
                            end
                        end
                    end


                    if notintabu == 1
                        % Add action to tabu list
                        
                        obj.TabuList(2:end) = obj.TabuList(1:end-1);
                        obj.TabuList(1) = {changedTask};

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
                    fprintf('.')
                end 
            catch err
                disp('ERROR in do action class')
                disp(err.stack)
                rethrow(err)
            end        
        end
                
        % Get stopping criteria:
        function [model,obj] = GetStoppingCriteria(obj, model)
            % Print cost and phase exit criteria:
            %fprintf([num2str(obj.LowestCost(1)), ' ' , ... 
            %    num2str(obj.IterationId-obj.NrOfBadIterationsBeforExit),'\n'])
            
            if obj.LowestCost(1) < ... 
                    obj.IterationId-obj.NrOfBadIterationsBeforExit || ...
                    obj.IterationId > obj.MaxPhaseIterations
                                currentPhase = model.phases(model.activePhaseIterator);
                
                % Recreate model when phase is over and set next phase:
                obj.TabuList = obj.CreateTabuList();

                % Take next in phase order
                nrPhases = size(model.phases,2);
                model.activePhaseIterator= ...
                    mod(model.activePhaseIterator,nrPhases)+1;
                
                
                % Save phase change:
                newPhase = model.phases(model.activePhaseIterator);
                if isempty(model.phaseChanges)
                    model.phaseChanges = [obj.IterationId, ...
                        currentPhase, newPhase, obj.LowestCost(2)*1E-13];
                else
                    model.phaseChanges = [model.phaseChanges; ...
                        [obj.IterationId, ...
                        currentPhase, newPhase, obj.LowestCost(2)*1E-13]];
                end

                obj.IterationId = 0;
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
            curSolution = zeros(obj.NrTasks,2);
            curSolution(:,1) = data.tasks(:,1);
            curSolution(:,2) = data.tasks(:,6);
            
            costStruct = CostFunction(data,curSolution,obj.CostWeight);
            costVec = [costStruct.total, costStruct.dep,costStruct.over,costStruct.bound];
            
        end
    end
end
