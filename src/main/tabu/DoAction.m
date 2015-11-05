function [status,data, tabuList] = DoAction(model,data,actionList,costList,tabuList,logfile )
%DOACTION Summary of this function goes here
%   Detailed explanation goes here


status = 0;
try
    
    % =========== 1st version: Using solutions ==========================
    [sortedCosts, indexes] = sort(costList);
    
    % Loop through min-solutions in ascending order
    for i = 1:length(costList)
        
        notintabu = 1;
        index = indexes(i);
        actionSolution = actionList{index}.actionSolution(:,2);
        
        % Compare solution with tabu list solutions
        for j = 1:length(tabuList)
            tabuSolution = tabuList{j};
            
            
            % Break if action in tabulist
            if isequal(tabuSolution, actionSolution) == 1
                notintabu = 0;
                break;
            end
        end

        
        if notintabu == 1
        
            % Add action to tabu list
            actioncell = num2cell(actionSolution, 1);
            tabuList(2:end) = tabuList(1:end-1);
            tabuList(1) = actioncell;
            
            
            % Perform action
            lowestCost = sortedCosts(i);
            data.tasks(:,6) = actionSolution;
            
            fprintf(logfile, ['Calculated ',num2str(length(costList)), ...
                ' actions. Lowest cost is ', num2str(lowestCost),'.\n']);
            break;
        end
        
    end
    
%     % ========== 2nd version: Using costs ============================
%     [sortedCosts, indexes] = sort(costList);
%     
%     for i = 1:length(costList)
%         
%         notintabu = 1;
%         index = indexes(i);
%         actionCost = sortedCosts(i);
%         
%         % Compare solution with tabu list solutions
%         for j = 1:length(tabuList)
%             tabuCost = tabuList(j);
%             
%             
%             % Break if action in tabulist
%             if tabuCost == actionCost
%                 notintabu = 0;
%                 break;
%             end
%         end
% 
%         
%         if notintabu == 1
%             
%             % Add action to tabu list
%             %actioncell = num2cell(actionSolution, 1);
%             tabuList(2:end) = tabuList(1:end-1);
%             tabuList(1) = actionCost;
%             
%             % Perform action
%             lowestCost = sortedCosts(i);
%             data.tasks(:,6) = actionList{index}.actionSolution(:,2);
%             
%             fprintf(logfile, ['Calculated ',num2str(length(costList)), ...
%                 ' actions. Lowest cost is ', num2str(actionCost), ...
%                 '. Chose action nr', num2str(i),'.\n']);
%             break;
%         end
%     end
%     
    
%     fprintf(logfile, ['Calculated ',num2str(length(costList)), ...
%         ' actions. Lowest cost is ', num2str(lowestCost),'.\n']);
    timenow = toc;
    fprintf(resultfile,[',',num2str(lowestCost),',',num2str(timenow),'\n']);
    

    status = 1;
catch err
    
    
    status = -1;
end
   


end

