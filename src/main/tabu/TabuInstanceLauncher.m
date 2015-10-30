function status = TabuInstanceLauncher(model, data, logfile, results)
%TABUINSTANCELAUNCHER Summary of this function goes here
%   Detailed explanation goes here

try
    switch model.activePhase
        case {1}
            disp('launching tabu phase instance 1');
            status = SimpleMoveOneTask(data);
        case {2}
            disp('launching tabu phase instance 2');
            %status = instance1(data);
        otherwise
            disp('unknown instance');
    end
catch err
   fprintf(logfile, getReport(err,'extended')); 
end

end
