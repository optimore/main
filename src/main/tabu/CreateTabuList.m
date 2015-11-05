function [status, tabuList] = CreateTabuList(model,data)
%CREATETABULIST create tabu list from model
% 
% v0.01: file setup, need implementation
% v.0.1 2015/11/03 skeleton development



% create tabu list from model
% probably taking the instance parameters into account somehow...
status = 0;

try
    switch model.phases
        case {1}
            % tabulist
            
            % 1st version
            listlength = 10;
            [no_tasks, m] = size(data.tasks);
            tabucell = num2cell(zeros(no_tasks, 1), 1);
            tabuList(1:listlength, 1) = tabucell;
            
%             % 2nd version
%             listlength = 10;
%             tabuList = zeros(listlength, 1);
            
        case {2}
            % no tabulist
            listlenght = 0;
        otherwise
            disp('unknown instance');
            
    end
    
    status = 1;
    
catch err
    fprintf(logfile, getReport(err,'extended'));
    rethrow(err)
    status = -1;
end

end

