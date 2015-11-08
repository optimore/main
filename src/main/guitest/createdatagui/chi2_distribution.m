function [ num ] = chi2_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Obs: det ska vara em fet svans åt höger, dvs lågt antal frihetsgrader.
%   Multiplicera resultatet för att få önskad varians och väntevärde. df =
%   3 eller 4! Snarare 3.
p = rand();


num = round(mu-sigma+sigma*chi2inv(p,3)/sqrt(6));

end

