function [status,data] = DoAction( model,data,actionList,costList,logfile )
%DOACTION Summary of this function goes here
%   Detailed explanation goes here


status = 0;
try
    lowestcostnotfound = 1;

    while lowestcostnotfound
        
        % 1. Find action generating lowest cost
        [lowestCost, index] = min(costList);
        
        data.tasks(:,6) = actionList{index}.actionSolution;
        disp('updated solution\n')
        
        % 2. Correlate with tabu list and
        break; % when not in tabu list
        
    end
    
    
    
    
    % 3 Choose action OR start from 1 with updated actionlist
    
    % 4. Add action to tabu list
    
    % 5. Update temporary solution
    
    status = 1;
catch err
    
    
    status = -1;
end
   


end

