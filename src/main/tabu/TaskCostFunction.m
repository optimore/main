function cost = TaskCostFunction(data)
% This is wrapper for all cost functions, dependencies, overlap and bounds
%   

% Calculate different cost functions

cost.dep = TaskDependencyCost(data);
cost.over = TaskOverlapCost(data);
cost.bound = TaskBoundsCost(data); 

% Calculate costs with weights
cost.total = cost.dep + cost.over + cost.bound;
end 
