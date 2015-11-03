function [ TimelineAttribute ] = createtimelineattribute(TimelineSolution,Attributegenerator,L, variance, mu, std3, distrib3, mu11, ...
        distrib5, std5, mu3)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Attributen måste hålla sig på tidslinjen.

% std3, distrib3, mu11 är för minimum

TimelineAttribute = zeros(length(TimelineSolution(:,1)),2);

for i=1:length(TimelineSolution(:,1))
    
    x=0;
    
    while x==0
        TimelineAttribute_prel = generate_attribute(TimelineSolution(i,:),L,mu11,std3,distrib3,mu3,std5,distrib5);
        if TimelineAttribute_prel(1) >= 0 && TimelineAttribute_prel(2) <= L
            TimelineAttribute(i,:) = TimelineAttribute_prel;
            x=1;
        end
    end
end

