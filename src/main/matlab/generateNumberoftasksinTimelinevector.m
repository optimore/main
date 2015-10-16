function [ NumberoftasksinTimelinevector ] = generateNumberoftasksinTimelinevector( Ntasks, Ntimelines )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
x=0;

NumberoftasksinTimelinevector = [];

while x==0
    numbers_vector = sort(randi(Ntasks,Ntimelines-1,1));
    NumberoftasksinTimelinevector = [numbers_vector(1); diff(numbers_vector); Ntasks-numbers_vector(end)];
    if min(NumberoftasksinTimelinevector) > floor(Ntasks/Ntimelines/1.5) % godtyckligt satt f.n.
        x=1;
    end
end

end

