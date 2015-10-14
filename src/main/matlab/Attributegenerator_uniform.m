function [ TimelineAttribute ] = Attributegenerator_uniform(TimelineSolution,L, space_param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
x=0;
while x == 0
    rand1 = randi(space_param,1,1);
    rand2 = randi(space_param,1,1);
    TimelineAttribute = [TimelineSolution(1)-rand1, TimelineSolution(2)+rand2];
    
    if TimelineAttribute(1) >= 0 && TimelineAttribute(2) <= L
        x=1;
    end
end
end

