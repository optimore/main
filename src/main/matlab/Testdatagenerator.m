function [ TimelineSolution, TimelineAttributeList, DependencyMatrix, DependencyAttribute ] = Testdatagenerator(N, L, T, generatelistoflength, ...
    generatelistofstartingpoints,generateNumberoftasksinTimelinevector, Attributegenerator, ...
    Generatedependencymatrix,Generatedependencyattributes,Ndependencies, variance1, mu1, variance2, mu2, occupancy, genlistoflengths_startpts)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

TimelineSolution = createsolution(N,L,T,generatelistoflength, ...
    generatelistofstartingpoints,generateNumberoftasksinTimelinevector, occupancy, genlistoflengths_startpts);

TimelineAttributeList={};

for n=1:T
    TimelineAttributeList{n} = createtimelineattribute(TimelineSolution{n}, Attributegenerator, L, variance1, mu1);
end

[DependencyMatrix, DependencyAttribute]=Dependencygenerator(TimelineSolution,Generatedependencymatrix,Generatedependencyattributes, ...
    Ndependencies, variance2, mu2, L, N, T);

end

