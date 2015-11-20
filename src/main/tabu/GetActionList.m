function [status,actionList,costList] = GetActionList(model, data, tabuList, logfile)
%GETACTIONLIST Create list of all posible changes and cost associated
%   the list contain a full solution set for every possible action
%   structarray('cost',val,'tasks setup',full task solution)
%   - uses model.activePhase for getting the tabu instance
%   - uses TabuInstanceLauncher to get the tabu instance
%   - the selected instance get all posible solutions
%  
% version:
% 0.02
% 0.01: minimal implementation, no tabulist

status = 0;

try
    [actionList,costList] = TabuInstanceLauncher(model, data, tabuList, logfile);
    status = 1;
catch err
    status = -1;
    rethrow(err)
end

end

