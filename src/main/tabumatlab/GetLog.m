function logfile = GetLog(logPath)
%% Get log file from path
% This function fetches the log and prepare it for logging test runs)
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: minor development, not tested
% 0.01: file setup
% Linköping University, Linköping

try
    logfile = fopen(logPath,'w')
catch ME
    fprintf ME
end

