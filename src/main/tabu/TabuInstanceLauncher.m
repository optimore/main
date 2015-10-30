function status = TabuInstanseLauncher(instanceNr, data, logfile)
%TABUINSTANSELIST Summary of this function goes here
%   Detailed explanation goes here

try
    switch instanceNr
        case {1}
            disp('launching tabu phase instance 1');
            status = instance1(data);
        case {2}
            disp('launching tabu phase instance 2');
            status = instance1(data);
        otherwise
            disp('unknown instance');

    end
catch err
   fprintf(logfile, getReport(err,'extended')); 
end

end
