function [status, logPath] = CreateLog()
%% Create one result folder for each test
% This function creates a result folder and returns a path to the file
%
% Created by: Victor Bergelin
% Date created: 04/11/2015
%
% Version number:
% 0.01: file setup
%
% Linköping University, Linköping

status = 0;

% 1. Get path and name:
relativeLogPath = 'target/logs/';

dateName = datestr(now(),'yyyy-mm-ddTHH-MM-SS');
logPath = [relativeLogPath,'log_',dateName];


% 2. Create file and close
try
    fclose(fopen(logPath, 'w'));
    status = 1;
catch err
    status = -1;
    rethrow(err)
end

% 3. Return file path and name

end