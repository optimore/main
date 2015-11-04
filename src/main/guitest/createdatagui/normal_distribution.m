function [ num ] = normal_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
p = rand();

num = round(max(0,norminv(p,mu,sigma)));

end

