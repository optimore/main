function [start_time_list, length_list] = genlistoflengths_startpts(L, N, occupancy)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

A = occupancy*L/N;

B = (1-occupancy)*L/(N+1);

start_time_list = [];
length_list = [];

time_it = 1;
previous = 1;
while time_it < L
    if previous == 0
        rand1 = randi(floor(2*A),1,1);
        length_list = [length_list; min(L-time_it,rand1)];
        time_it = time_it+rand1;
        previous = 1;
    else
        rand2 = randi(floor(2*B),1,1);
        if time_it+rand2 < L
            start_time_list = [start_time_list; time_it+rand2];
        end
        time_it = time_it+rand2;
        previous = 0;
    end
end

