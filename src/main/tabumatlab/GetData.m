function model=GetData(dataDirectory)
%% Combind models from parameters
% This function creates a model from given parameters
% Created by: Victor Bergelin
% Date created: 28/10/2015
% Version number 
% 0.02: minor development, not tested
% 0.01: file setup
% Link�ping University, Link�ping

model = modelParameters

switch par.cmp
    case 1
        % A - data
        depmean = 0;
    case 2
        % B - data
        
        print('no B-data');
        % depmean = 3;        
    case 3
        % C - data
        
        print('no C-data');
        depmean = 30;
    end

end