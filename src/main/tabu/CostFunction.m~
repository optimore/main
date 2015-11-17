function cost = CostFunction(data, tempSolution, weights)
% This is wrapper for all cost functions, dependencies, overlap and bounds
%   

% Calculate different cost functions

costDependencies = DependencyCost(data,tempSolution);
costOverlap = OverlapCost(data,tempSolution);
costBounds = BoundsCost(data,tempSolution);

% Calculate costs with weights
cost.dep = weights(1)*costDependencies;
cost.over = weights(2)*costOverlap;
cost.bound = weights(3)*costBounds;
cost.total = cost.dep + cost.over + cost.bound;
end

