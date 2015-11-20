function [TimelineSolution] = createsolution(N, L, T,generatelistoflength,generatelistofstartingpoints,generateNumberoftasksinTimelinevector, occupancy, ...
    genlistoflengths_startpts, std7, distrib7, distrib8, std8, distrib4, std4)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

NumberoftasksinTimelinevector = generateNumberoftasksinTimelinevector(N,T, distrib8, std8);

TimelineSolution = {};

% G�r ett element av nedanst��ende, som stoppas in i TimelineSolution.
for n=1:T
    
	N=NumberoftasksinTimelinevector(n);
%     listofstartingpoints= generatelistofstartingpoints(L, N);
    % size(listofstartingpoints,1)
    % genlistoflength m�ste nog moddas lite.
%     listoflength=generatelistoflength(listofstartingpoints,L);
    [listofstartingpoints, listoflength] = genlistoflengths_startpts(L, N, occupancy, distrib4, std4, std7, distrib7);

    TimelineSolution{n} = [listofstartingpoints, listoflength];
end

end


