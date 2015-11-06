function [ num ] = chi2_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
p = rand();


num = round(mu-sigma+chi2inv(p,sigma));

end

