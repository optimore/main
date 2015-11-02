function C=OverlapCost(data, model)
%% Task Interval
% needs comments!


C = 0;
overlap= 0;

n=model.n_tasks;

for i=1:n-1
    start1 = model.start_t(i);
    end1 = start1 + model.length(i);
    for j=i+1:n
        start2 = model.start_t(j);
        end2 = start2 + model.length(j);
        
        if start1 < start2 && start2 < end1
            overlap = end1 - start2;
            if end2 < end1
                overlap = overlap - (end1 -end2);
            end
        end
        C = C + overlap;
    end   
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