function status = SimpleSortAndPlace(data,model)
%% Put the task in the middle of the allowed area
%   Detailed explanation goes here
% v.0.01: simplest possible, lacks status/error handling


% 1. This can later be used for error reporting
status = 0;

% 2. Put tasks in place
nrtasks = size(data.tasks,1);
for i = 1:nrtasks
    meanplace = mean(data.tasks(i,2:3));
    length = data.tasks(i,5);
    data.tasks(i,6) = meanplace-length/2;
end

end
