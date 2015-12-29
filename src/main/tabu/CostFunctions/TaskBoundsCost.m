function C = TaskBoundsCost(data)
%% Calculate TaskBoundsCost
% Calulates cost for tasks that are outside their bounds on the timeline
% 
% Created by: Victor Bergelin and Emelie Karlsson
% 
% Version number: 1.0
% 0.01: minimal usage implementation
% 1.0: Clean and commented code

% Initially 0 cost
C = zeros(size(data,1), 1);
overlap= 0;

% Loop over all tasks
[no_tasks, m] = size(data.tasks);

try
    for i=1:no_tasks
        bound_cost = 0;
        start_task = data.tasks(i,6);
        end_task = start_task + data.tasks(i,5);
        
        start_min = data.tasks(i,2);
        end_max = data.tasks(i,3);
        
        if start_task < start_min
            bound_cost = (start_min - start_task)^2;
            
        elseif end_task > end_max
            bound_cost = (end_task - end_max)^2;
            
        end
        
        C(i) = bound_cost;
        
    end
catch err
    fprintf(obj.Logfile, getReport(err,'extended'));
    rethrow(err)
end

end

