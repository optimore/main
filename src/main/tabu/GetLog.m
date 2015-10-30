function logfile = GetLog(logfileParameters)
%% Get log file from path
% This function fetches the log and prepare it for logging test runs)
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: minor development, not tested
% 0.01: file setup
% Linköping University, Linköping

try
    logfile = fopen(logfileParameters.path,'a+');
    
    fprintf(logfile,['---------------------------------------\n', ...
        'Tabu-log initiated: ', datestr(now()), '\n\n']);
    
catch err
    disp(err.stack);
end

