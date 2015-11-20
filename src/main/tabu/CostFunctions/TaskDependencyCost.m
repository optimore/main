function C = TaskDependencyCost(data)
% Calculates cost for pairs of dependenent tasks
% Finds the interval in which the second task in the dependency should start.
% Calculates how much the placement of task two differes from this
% interval.
% First version 2015-11-02

% Initially 0 cost
C = zeros(size(data,1), 1);
[no_dependencies, m] = size(data.dependencies);

try
    % Loop over all dependencies
    for i=1:no_dependencies
        dep_cost = 0;
        
        task_1 = data.dependencies(i,1);
        task_2 = data.dependencies(i,2);
        
        start_task1 = data.tasks(task_1,6);
        start_task2 = data.tasks(task_2,6);
        
        end_task1 = start_task1 + data.tasks(task_1,5);
        
        min_start2 = end_task1 + data.dependencies(i,3);
        max_start2 = end_task1 + data.dependencies(i,4);
        
        % Check if task two is in designated interval
        if start_task2 < min_start2
            dep_cost = (min_start2 - start_task2)^2;
            
        elseif start_task2 > max_start2
            dep_cost = (start_task2 - max_start2)^2;
            
        end
        
        C(task_1) = C(task_1) + dep_cost;
        C(task_2) = C(task_2) + dep_cost;
        
    end
catch err
    disp(getReport(err,'extended'))
    %fprintf(obj.Logfile, getReport(err,'extended'));
    rethrow(err)
    
end


end

