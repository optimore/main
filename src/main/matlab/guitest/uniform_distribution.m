function [ num ] = uniform_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a = mu-sqrt(3)*sigma;
b = mu+sqrt(3)*sigma;
if a <0
    a=0;
    b=b+a;
end

num = max(0,floor(randi(round(b-a+1),1,1)+round(a)));

end

