function data=GetData(dataParameters,logfile)
%% Combind models from parameters
% This function creates a model from given parameters
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: 
% 0.01: file setup
% Linköping University, Linköping

try
    % 1. Load data
    timelineAttr = load( ...
        [dataParameters.path,'TimelineAttributes.dat']);
        
    depencencyAttr = load( ...
        [dataParameters.path,'DependencyAttributes.dat']);
    
    depencencyMat = load( ...
        [dataParameters.path,'DependencyMatrix.dat']);

    timelineSolution = load( ...
        [dataParameters.path,'TimelineSolution.dat']);
 
    % 2. Create task representation
    nrtasks = length(timelineAttr);
    data.taskcolumnname = {'id','first start time','last end time', ...
        'timeline id', 'task length', ...
        'actual start time placement (so that the task can move; =0 now)'};
    data.tasks = zeros(nrtasks,6);
    data.tasks(:,1) = [1:nrtasks]';
    data.tasks(:,2:4) = round(timelineAttr(:,1:3));
    data.tasks(:,5) = timelineSolution(:,2);
    
    % 3. Create dependency representation
    nrdependencies = size(depencencyMat,1);
    data.depencencies = zeros(nrdependencies,4);
    
    for i = 1:nrdependencies
        data.dependencies(i,1) = GetId(depencencyMat(i,3:4),data.tasks);
        data.dependencies(i,2) = GetId(depencencyMat(i,1:2),data.tasks);
        data.dependencies(i,3:4) = depencencyAttr(i,1:2);
    end
    
    % Uncomment to print the tasks and dependencies:
    % data.tasks
    % data.dependencies
    
catch err
    % disp('error'); %err.stack.name)
    fprintf(logfile, 'Error loading data');
    fprintf(logfile, getReport(err,'extended'));
    rethrow(err);
end

%return data;


function id = GetId(taskandtimeline,alltasks)
    % search and extract all tasks for the matching timeline:
    selecttl = alltasks(find(alltasks(:,4)==taskandtimeline(2)),:);
    id = selecttl(taskandtimeline(1),1);
% return id 