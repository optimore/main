function status = InitialSolutionLauncher(model,data,logfile)
% This launcher initiates a given starting solution from a function call
%
% v 0.01 Launches SimpleSortAndPlace
%
% Victor Bergelin

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
   fprintf(logfile, 'Error in Starting Condition Launcher, aborting.\n'); 
   fprintf(logfile, getReport(err,'extended')); 
   rethrow(err)
end


end

