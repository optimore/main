function [DependencyMatrix, DependencyAttribute] = Dependencygenerator(TimelineSolution,Generatedependencymatrix,Generatedependencyattributes, ...
    Ndependencies, variance, mu, L, N, T)

%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

DependencyMatrix=Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu);


% if 
% something is wrong with  DependencyMatrix
% then send warning and go to repeat1
% repeat2
DependencyAttribute=Generatedependencyattributes(TimelineSolution, DependencyMatrix, variance, mu, L, N, T);


% if 
% something is wrong with DependencyAttribute
% then send warning and go to repeat2
% end:


end

