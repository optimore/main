function [DependencyMatrix, DependencyAttribute] = Dependencygenerator(TimelineSolution,Generatedependencymatrix,Generatedependencyattributes, ...
    Ndependencies, variance, mu, L, N, T, rectify, distrib6, std6, mu4, std2, distrib2, mu2,constrain)

%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

DependencyMatrix=Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu, rectify,constrain);


% if 
% something is wrong with  DependencyMatrix
% then send warning and go to repeat1
% repeat2
DependencyAttribute=Generatedependencyattributes(TimelineSolution, DependencyMatrix, variance, mu, L, N, T, distrib6, std6, mu4, std2, distrib2, mu2);


% if 
% something is wrong with DependencyAttribute
% then send warning and go to repeat2
% end:


end

