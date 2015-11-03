function C = BoundsCost(data)
%% Tasks are outside their designated interval
%   Detailed explanation goes here

% Initially 0 cost
C = 0;
overlap= 0;

% Loop over all tasks
[no_tasks, m] = size(data.tasks);

for i=1:no_tasks
    bound_cost = 0;
    start_task = data.tasks(i,6);
    end_task = start_task + data.tasks(i,5);
    
    start_min = data.tasks(i,2);
    end_max = data.tasks(i,3);
    
    if start_task < start_min
        bound_cost = start_min - start_task;
        
    elseif end_task > end_max
        bound_cost = end_task - end_max;
        
    end
    
    C = C + bound_cost;

end

