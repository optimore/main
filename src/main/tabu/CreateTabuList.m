function [status, tabuList] = CreateTabuList(model)
%CREATETABULIST create tabu list from model
% 
% v0.01: file setup, need implementation
% v.0.1 2015/11/03 skeleton development



% create tabu list from model
% probably taking the instance parameters into account somehow... 
status = 0;

% OBS temporary for development
model.tabulist = 1;

try
    switch model.tabulist
        case {1}
            listlength = 10;
        case {2}
        otherwise
            disp('unknown instance');
            
    end
    
    %tabuList = zeros(listlength);
    tabuList = [];
    status = 1;

catch err
   fprintf(logfile, getReport(err,'extended')); 
   rethrow(err)
   status = -1;
end

end

