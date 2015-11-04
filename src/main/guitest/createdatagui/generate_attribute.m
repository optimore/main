function [ TimelineAttribute ] = generate_attribute(TimelineSolution,L,mu1,sigma1,distribution1,mu2,sigma2,distribution2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% scaling = (TimelineSolution(2)-TimelineSolution(1))/4;

scale_factor = TimelineSolution(2);

rand1 = TimelineSolution(1)-distribution1(mu1*scale_factor*10,sigma1*scale_factor*10);
rand2 = TimelineSolution(2)+TimelineSolution(1)+distribution2(mu2*scale_factor*10,sigma2*scale_factor*10);
% rand1 = norminv(rand(1,1),TimelineSolution(1)-mu*scaling,sigma);
% rand2 = norminv(rand(1,1),TimelineSolution(2)+mu*scaling,sigma);
TimelineAttribute = [max(0,rand1), min(L,rand2)];

end

