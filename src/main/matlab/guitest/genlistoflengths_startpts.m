function [start_time_list, length_list] = genlistoflengths_startpts(L, N, occupancy, distrib4, std4, std7, distrib7)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

std4 = std4/(1+std4);
std7 = std7/(1+std7);

A = occupancy*L/(N+1);

B = (1-occupancy)*L/(N+1);

start_time_list = [];
length_list = [];

std1 = std4*L/N;

std2 = std7*L/N;

time_it = 1;
previous = 1;
while time_it < L
    if previous == 0
        % här ska std4, distrib4 in
        rand1 = distrib4(A,std1);
        while rand1 < A/20
            rand1 = distrib4(A,std1);
        end
        % rand1 = randi(floor(2*A),1,1);
        length_list = [length_list; min(L-time_it,rand1)];
        time_it = time_it+rand1;
        previous = 1;
    else
        % Här ska std7, distrib7 in.
        rand2 = distrib7(B,std2);
        while rand2 < B/20 || rand2 > L/2
            rand2 = distrib7(B,std2);
        end
        % rand2 = randi(floor(2*B),1,1);
        if time_it+rand2 < L
            start_time_list = [start_time_list; time_it+rand2];
        end
        time_it = time_it+rand2;
        previous = 0;
    end
end

