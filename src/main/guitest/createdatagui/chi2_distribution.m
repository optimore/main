function [ num ] = chi2_distribution(mu, sigma)
%UNTITLED Summary of this function goes here
%   Obs: det ska vara em fet svans �t h�ger, dvs l�gt antal frihetsgrader.
%   Multiplicera resultatet f�r att f� �nskad varians och v�ntev�rde. df =
%   3 eller 4! Snarare 3.
p = rand();


num = round(mu-sigma+sigma*chi2inv(p,3)/sqrt(6));

end

