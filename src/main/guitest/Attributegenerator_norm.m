function [ TimelineAttribute ] = Attributegenerator_norm(TimelineSolution,L,variance,mu)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

scaling = (TimelineSolution(2)-TimelineSolution(1))/4;

sigma = scaling*sqrt(variance);

rand1 = norminv(rand(1,1),TimelineSolution(1)-mu*scaling,sigma);
rand2 = norminv(rand(1,1),TimelineSolution(2)+mu*scaling,sigma);
TimelineAttribute = [max(0,rand1), min(L,rand2)];

end

