function [ TimelineAttribute ] = Attributegenerator_uniform(TimelineSolution,L,variance,mu)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

space_param = floor((TimelineSolution(2)-TimelineSolution(1))*(sqrt(variance)+mu)/3);

% Borde specialbehandla punkterna i början och slutet eftersom det kan vara
% väldigt svårt att få in dem.

rand1 = randi(space_param,1,1)-1;
rand2 = randi(space_param,1,1)-1;
TimelineAttribute = [TimelineSolution(1)-rand1, TimelineSolution(2)+rand2];

end

