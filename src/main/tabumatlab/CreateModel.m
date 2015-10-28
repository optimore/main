%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA116
% Project Title: Implementation of Tabu Search for TSP
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function model=CreateModel()

   % Task dimensions: INITIAL SOLUTION
   order = [1 2 3 4 5 6 7];
   start_t = [0 11 35 40 55 90 97];
   length = [10 20 2 10 30 5 1];
   
   % Task dependencies
   dep = [[1 3] [5 6]];
   n_dep = numel(dep);
   n=numel(order);

   % Distance between dep. tasks
   min_dep_dist = [20 0];
   max_dep_dist = [30 3];
   
   % Task min max start and end
   start_tmin= [0 0 30 30 50 50 60];
   end_tmax= [30 30 40 100 100 100 100];
    
   model.n_tasks=n;
   model.order=order;
   model.length=length;
   model.dep=dep;
   model.n_dep=n_dep;
   model.min_dep_dist=min_dep_dist;
   model.max_dep_dist=max_dep_dist;
   model.min_start_t=start_tmin;
   model.max_end_t=end_tmax;
   % I.S.
   model.start_t=start_t;
    
end