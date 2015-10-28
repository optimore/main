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

function C=TaskInverval(model)

C = 0;
cost = 0;

n=model.n;

for i=1:n
    start_t = model.start_t(i);
    end_t = model.end_t(i);
    start_min = model.min_start_t(i);
    end_max = model.min_start_t(i);
    
    if start_t < start_min
        cost = abs(start_t - start_min);
    end
    
    if end_t > end_max
        cost = abs(start - end_max);
    end
    


C = C + cost;

end
% 
% Old code
% n=numel(tour);
% 
% tour=[tour tour(1)];
% 
% C=0;
% 
% for k=1:n
%     
%     i=tour(k);
%     j=tour(k+1);
%     
%     L=L+model.d(i,j);
%     
% end

% Comment: can tasks be placed at the exact same time?

end