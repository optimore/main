function [ TimelineAttribute ] = createtimelineattribute(TimelineSolution,Attributegenerator,L, variance, mu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Attributen måste hålla sig på tidslinjen.

TimelineAttribute = zeros(length(TimelineSolution(:,1)),2);

for i=1:length(TimelineSolution(:,1))
    
    x=0;
    
    while x==0
        TimelineAttribute_prel = Attributegenerator(TimelineSolution,L,variance,mu);
        if TimelineAttribute_prel(1) >= 0 && TimelineAttribute_prel(2) <= L
            TimelineAttribute(i,:) = TimelineAttribute_prel;
            x=1;
        end
    end
end

