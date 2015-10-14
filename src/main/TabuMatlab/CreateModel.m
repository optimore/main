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

   order = [1 2 3 4 5 6 7];
   start_t = [0 11 35 40 55 90 97];
   length = [10 20 2 10 30 5 1];
    
   n=numel(order);

   start_tmin= [0 0 30 30 50 50 60];
   end_tmax= [30 30 40 100 100 100 100];
    
   model.n=n;
   model.order=order;
   model.length=length;
   model.start_t=start_t;
   model.start_tmin=start_tmin;
   model.end_tmax=end_tmax;
    
end