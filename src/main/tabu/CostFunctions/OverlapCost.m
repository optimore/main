function C=OverlapCost(data)
%% Calulates cost for tasks that are overlapping on timeline
% Compares the starting and ending time of all tasks in the data.
% Accumulates result in C. One time unit overlap is one cost unit in C.
% First version 2015-11-02

% Initially 0 cost
C = 0;
overlap= 0;

% Loop over all tasks
[no_tasks, m] = size(data.tasks);


for i=1:no_tasks-1

    timeline1 = data.tasks(i,4);
    % Column 6: current solution
    start_task1 = data.tasks(i,6);
    %min_start_task1 = data.tasks(i,2);
    length_task1 = data.tasks(i,5);
    end_task1 = start_task1 + length_task1;
    
    for j=i+1:no_tasks
        timeline2 = data.tasks(j,4);
        
        % Compare tasks on the same timeline
        if timeline1 == timeline2
            start_task2 = data.tasks(j,6);
            %min_start_task2 = model.tasks(j,2);
            length_task2 =  data.tasks(j,5);
            end_task2 = start_task2 + length_task2;

            % If task two starts after task one - two cases of overlap
            if start_task2 >= start_task1 && start_task2 <= end_task1
                if end_task2 >= end_task1
                    overlap = end_task1 - start_task2;
                elseif end_task2 <= end_task1
                    overlap = length_task2;
                end

            % If task two starts before task one - two cases of overlap
            elseif start_task2 <= start_task1 
                if end_task2 >= start_task1 && end_task2 <= end_task1
                    overlap = end_task2 - start_task1;
                elseif end_task2 >= end_task1
                    overlap = length_task1;
                end
            end
            C = C + overlap
        end
    end   
end


end