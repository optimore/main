function [DependencyAttribute] = Generatedependencyattributes(TimelineSolution, DependencyMatrix, variance, mu, L, N, T, distrib6, std6, mu4, std2, distrib2, mu2)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Givet en dependency är detta enkelt. Bara som i den andra
% attribut-generatorn.

% distrib6 = min time.

DependencyAttribute = zeros(size(DependencyMatrix,1),2);

Scaling = ceil(L/4); % dividerar ej med antalet tasks, ska vara i förhållande till tidslinjens längd.

for i=1:size(DependencyMatrix,1)
    task1_end = TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),1) + ...
        TimelineSolution{DependencyMatrix(i,2)}(DependencyMatrix(i,1),2);
    
    task2_begin = TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),1);
    
    task2_end = TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),1) + ...
        TimelineSolution{DependencyMatrix(i,4)}(DependencyMatrix(i,3),2);
    
%     rand1 = randi(Scaling,1,1)-1;
%     rand2 = randi(Scaling,1,1)-1;

    x=0;
    % För att få konvergens någon gång.
    mod_scaling = min(Scaling,task2_begin-task1_end);
    while x==0
        rand1 = distrib6(mod_scaling*mu4,mod_scaling*std6);
        fdmin = task2_begin-task1_end-rand1;
        if fdmin >= 0
            x=1;
        end
        
    end
    x=0;
    while x==0
        rand2 = distrib2(Scaling*mu2,Scaling*std2);
        
        fdmax = min(L-(task2_end-task2_begin),task2_begin-task1_end+rand2);
        if fdmax > fdmin
            x=1;
        end
    end
    
    DependencyAttribute(i,:) = [fdmin, fdmax];
    
end

% Ta fram första tasken i dependency. Hitta dess sluttid
% Ta fram andra tasken i dependency. Hitta dess start/sluttid

% Beräkna differenser och subtrahera resp addera slumptal.

end

