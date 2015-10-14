function [start_time_vector] = generatelistofstartingpoints(L, N)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
x=0;

space_param = floor(L/N/5);

start_time_vector = [];

first_start_time = randi(space_param,1,1)-1;

while x==0
    
    start_time_vector = [first_start_time; randi(L-first_start_time-1,N,1)+first_start_time];
    
    start_time_vector = sort(start_time_vector);
    
    % Generera starttider och sluttider. Separat på något sätt.
    
    if min(diff(start_time_vector))>space_param && start_time_vector(end) < L-space_param % godt. satt
        x=1;
    end
end


end
