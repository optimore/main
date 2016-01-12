% Created by: Isak Bohman, 2015
function Listoflength = generatelistoflength(listofstartingpoints,L)
% Deprecated? Generates a list of task lengths.

Ntasksn = length(listofstartingpoints);

density_param = 0.6;

space_param = floor(L/Ntasksn*density_param);

x=0;

end_time_vector = [];
Listoflength = [];

% Generate numbers from the beginning so that they satisfy start_i < end_i <
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

%special treatment to last one. end_time must be less than L.


end

