function resultPath = CreateResult(resultParameters,logfile)
%CREATERESULT Summary of this function goes here
%   Detailed explanation goes here
%
% v0.01: file setup done, needs implementation and error handling!


% 1. Get path
resultPath = resultParameters.path;
resultId = resultParameters.id;

% 2. Create result file
resultPath = [resultPath,'/tabu'];

try
    fclose(fopen(resultPath, 'w'));
    fprintf(logfile, ['Result file created: ', resultPath, ...
        '\n\n']);
    status = 1;
catch err
    status = -1;
    rethrow(err)
end

% 3. Return file path and name

end

