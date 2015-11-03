function cost = CostFunction(data, tempSolution, weights)
% This is wrapper for all cost functions, dependencies, overlap and bounds
%   

% Calculate different cost functions *NEED IMPLEMENTATION*

costDependencies = DependencyCost(data)
costOverlap = OverlapCost(data)
costBounds = BoundsCost(data)

% Calculate costs with weights
cost =  weights(1)*costDependencies + ...
        weights(2)*costOverlap + ...
        weights(3)*costBounds;

end

