function [actionList,costList] = TabuInstanceLauncher(model, data, tabuList, logfile)
%TABUINSTANCELAUNCHER Launches the active instance for the phase
% Detailed explanation goes here
% version
% 0.01: minimal usage implementation for one instance and phase

try
    switch model.activePhase
        case {1}
            [actionList,costList] = SimpleMoveOneTask(data, logfile);
        case {2}
            msg = 'No instance for id 2 exist';
            disp(msg);
            error(msg);
        otherwise
            disp('unknown instance');
    end
catch err
   fprintf(logfile, getReport(err,'extended')); 
   rethrow(err)
end

end
