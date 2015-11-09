function [status,data] = InitialSolutionLauncher(model,data,logfile)
% This launcher initiates a given starting solution from a function call
%
% v 0.01 Launches SimpleSortAndPlace
%
% Victor Bergelin

try
    switch model.initialSolution
        case {1}
            [status,data] = SimpleSortAndPlace(data);
        case {2}
            msg = 'No initial solution for id 2 exist';
            disp(msg);
            error(msg);
        otherwise
            disp('unknown instance');
    end
catch err
   fprintf(logfile, 'Error in Starting Condition Launcher, aborting.\n'); 
   fprintf(logfile, getReport(err,'extended')); 
   rethrow(err)
end


end

