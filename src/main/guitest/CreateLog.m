function logpath = CreateLog()
%% Create one log file for each test
% This function creates a log file and returns a path to the file
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.01: file setup
% Link�ping University, Link�ping

% 1. Get path and name:
relativeLogPath = 'target/logs/';

dateName = datestr(now(),'yyyy-mm-ddTHH-MM-SS')
logpath = [dateName,'.log'];


% 2. Create file
try
    fclose(fopen([relativeLogPath,logpath], 'w'));
catch ME
    disp('Error in Create Log');
     
end

% 3. Return file path and name

end

