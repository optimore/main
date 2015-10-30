function status = MoveOneTask01(data)
%% Phase instance 1 in tabu search
% This instance will move one task with different step length eatch iteration
% The stoping criteria is costfunction = 0
% version nr:
% 0.01: initial testing with -10, -1, 1, 10 steps
%

% 1. Initiate:
disp('running MoveOneTask01');


% 2. 


% 3. 



status = 0;

end


% 
%  function model=CreateModel()
% 
%    % Task dimensions: INITIAL SOLUTION
%    order = [1 2 3 4 5 6 7];
%    start_t = [0 11 35 40 55 90 97];
%    length = [10 20 2 10 30 5 1];
%    
%    % Task dependencies
%    dep = [[1 3] [5 6]];
%    n_dep = numel(dep);
%    n=numel(order);
% 
%    % Distance between dep. tasks
%    min_dep_dist = [20 0];
%    max_dep_dist = [30 3];
%    
%    % Task min max start and end
%    start_tmin= [0 0 30 30 50 50 60];
%    end_tmax= [30 30 40 100 100 100 100];
%     
%    model.n_tasks=n;
%    model.order=order;
%    model.length=length;
%    model.dep=dep;
%    model.n_dep=n_dep;
%    model.min_dep_dist=min_dep_dist;
%    model.max_dep_dist=max_dep_dist;
%    model.min_start_t=start_tmin;
%    model.max_end_t=end_tmax;
%    % I.S.
%    model.start_t=start_t;
%     
%  end