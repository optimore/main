function [status, conditionsAreNotMet] = AreConditionsMet(costList)
%ARECONDITIONSMET Summary of this function goes here
%   Detailed explanation goes here

status = 0;
try
    if min(costList)==0
        conditionsAreNotMet = 0;
    else
        conditionsAreNotMet = 1;
    end
    status = 1;
catch err
    status = -1;
    rethrow(err)    
end

