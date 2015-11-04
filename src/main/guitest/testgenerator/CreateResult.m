function [status, resultPath] = CreateResult()
%% Create one log file for each test
% This function creates a log file and returns a path to the file
% Created by: Victor Bergelin
%
% Date created: 28/10/2015
%
% Version number 
% 0.01: file setup
% Linköping University, Linköping

% 1. Get path and name:
relativeLogPath = 'target/results/';

dateName = datestr(now(),'yyyy-mm-ddTHH-MM-SS')
resultPath = ['results_', dateName];


% 2. Create file and close
try
    mkdir(resultPath)
    %fclose(fopen([relativeLogPath,logpath], 'w'));
catch ME
     
end

% 3. Return file path and name

end


