function cost = CostFunction(data,tempSolution,weights)
% This is wrapper for all cost functions, dependencies, overlap and bounds
%   

% Calculate different cost functions
costDependencies = DependencyCost(data,model)
costOverlap = OverlapCost(data,model)
costBounds = BoundsCost(data,model)

% Calculate costs with weights
cost =  weights(1)*costDependencies + ...
        weights(2)*costOverlap + ...
        weights(3)*costBounds;

end

