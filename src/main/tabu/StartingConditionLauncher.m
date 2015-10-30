function data = StartingConditionLauncher(model,data)
%StartingConditionLauncher Summary of this function goes here
%   Detailed explanation goes here


model.activePhase
try
    switch model.initialSolution
        case {1}
            disp('launching tabu phase instance 1');
            status = SimpleSortAndPlace(data);
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

