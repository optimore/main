% Created by: Isak Bohman, 2015
function [start_time_vector] = generatelistofstartingpoints(L, N)
% Generates a list of starting points for tasks. Deprecated?
x=0;

% Scaling paraneter.
space_param = floor(L/N/3);

start_time_vector = [];

first_start_time = randi(space_param,1,1)-1;

while x==0
    
    start_time_vector = [first_start_time; randi(L-first_start_time-1,N-1,1)+first_start_time];
    
    start_time_vector = sort(start_time_vector);
    
    % Generate starting times and ending times.
    
    if min(diff(start_time_vector))>space_param && start_time_vector(end) < L-space_param % godt. satt
        x=1;
    end
end


end
