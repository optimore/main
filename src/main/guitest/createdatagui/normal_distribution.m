function [ num ] = normal_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
p = 0.5*rand()+0.5;


num = round(norminv(p,mu,sigma));


end

