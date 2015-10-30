function data=GetData(dataParameters)
%% Combind models from parameters
% This function creates a model from given parameters
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: 
% 0.01: file setup
% Linköping University, Linköping

try
    data.timelineAttr = load( ...
        [dataParameters.path,'TimelineAttributes.dat']);
        
    data.depencencyAttr = load( ...
        [dataParameters.path,'DependencyAttributes.dat']);
    
    data.depencencyMat = load( ...
        [dataParameters.path,'DependencyMatrix.dat']);
   
catch err
    fprintf(logfile, 'Error loading data');
    fprintf(logfile, getReport(err,'extended'));
    rethrow(err);
end

end