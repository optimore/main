function Listoflength = generatelistoflength(listofstartingpoints,L)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Ntasksn = length(listofstartingpoints);

density_param = 0.6;

space_param = floor(L/Ntasksn*density_param);

x=0;

end_time_vector = [];
Listoflength = [];

% Generera talen från början så att de uppfyller start_i < slut_i <
% start_{i+1}

for i=1:Ntasksn-1
    
    while x==0
        end_time = listofstartingpoints(i+1)-randi(space_param,1,1);
        if listofstartingpoints(i+1) > end_time && end_time > listofstartingpoints(i)
            Listoflength = [Listoflength; end_time-listofstartingpoints(i)];
            end_time_vector = [end_time_vector; end_time];
            x=1;
        end
    end
    x=0;
end

while x==0
    end_time = L-randi(space_param,1,1);
    if listofstartingpoints(end) < end_time && end_time > listofstartingpoints(i)
        Listoflength = [Listoflength; end_time-listofstartingpoints(end)];
        end_time_vector = [end_time_vector; end_time];
        x=1;
    end
end

%specialbehandla sista. end_time måste vara mindre än L.


end

