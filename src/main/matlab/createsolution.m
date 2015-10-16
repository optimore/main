function [TimelineSolution] = createsolution(N, L, T,generatelistoflength,generatelistofstartingpoints,generateNumberoftasksinTimelinevector)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

NumberoftasksinTimelinevector = generateNumberoftasksinTimelinevector(N,T);

TimelineSolution = {};

% Gör ett element av nedanst¨ående, som stoppas in i TimelineSolution.
for n=1:T
    
	N=NumberoftasksinTimelinevector(n);
    listofstartingpoints= generatelistofstartingpoints(L, N);
    % size(listofstartingpoints,1)
    % genlistoflength måste nog moddas lite.
    listoflength=generatelistoflength(listofstartingpoints,L);
    
    TimelineSolution{n} = [listofstartingpoints, listoflength];
end

end


