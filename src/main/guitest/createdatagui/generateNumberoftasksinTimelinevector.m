function [ NumberoftasksinTimelinevector ] = generateNumberoftasksinTimelinevector( Ntasks, Ntimelines, distrib8, std8 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
x=0;

mu = Ntasks/Ntimelines;
std = std8*mu;

NumberoftasksinTimelinevector = [];

if Ntimelines == 1
    NumberoftasksinTimelinevector = Ntasks;
else
    
    %     while x==0
    %         % Gör approximation redan vid detta skede.
    %
    %         numbers_vector = sort(randi(Ntasks,Ntimelines-1,1));
    %         NumberoftasksinTimelinevector = [numbers_vector(1); diff(numbers_vector); Ntasks-numbers_vector(end)];
    %         if min(NumberoftasksinTimelinevector) > floor(Ntasks/Ntimelines/1.5) % godtyckligt satt f.n.
    %             x=1;
    %         end
    %     end
    
    for i=1:Ntasks
        x=0;
        % Skapa tal som har fördelningen distrib8, med mu och std8
        while x==0
            NumberoftasksinTimelinevector_element = round(distrib8(mu,std)); % kalibrera detta!
            
            if NumberoftasksinTimelinevector_element > max(1,floor(Ntasks/Ntimelines/5)) % godtyckligt satt f.n.
                x=1;
                NumberoftasksinTimelinevector = [NumberoftasksinTimelinevector; NumberoftasksinTimelinevector_element];
            end
        end
    end
    
    
end

end

