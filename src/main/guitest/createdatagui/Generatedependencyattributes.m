function [DependencyAttribute] = Generatedependencyattributes(TimelineSolution, DependencyMatrix, variance, mu, L, N, T, distrib6, std6, mu4, std2, distrib2, mu2)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Givet en dependency är detta enkelt. Bara som i den andra
% attribut-generatorn.

% distrib6 = min time.

DependencyAttribute = zeros(size(DependencyMatrix,1),2);

Scaling = ceil(L*T/4/N);

for i=1:size(DependencyMatrix,1)
    task1_end = TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),1) + ...
        TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),2);
    
    task2_begin = TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),1);
    
    task2_end = TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),1) + ...
        TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),2);
    
%     rand1 = randi(Scaling,1,1)-1;
%     rand2 = randi(Scaling,1,1)-1;
    
    rand1 = distrib6(Scaling*mu4,Scaling*std6);
    rand2 = distrib2(Scaling*mu2,Scaling*std2);
    
    fdmin = max(0,task2_begin-task1_end-rand1);
    fdmax = min(L-(task2_end-task2_begin),task2_begin-task1_end+rand2);

    
    DependencyAttribute(i,:) = [fdmin, fdmax];
    
end

% Ta fram första tasken i dependency. Hitta dess sluttid
% Ta fram andra tasken i dependency. Hitta dess start/sluttid

% Beräkna differenser och subtrahera resp addera slumptal.

end

