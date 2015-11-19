function status = LNSmain(dataParameters, tabuParameters, logfileParameters, resultParameters)
%% Tabu main launching script
% This script is the over all launcher of the tabu search algorithm
%
% TODO: 
% - Catch user force-quit and handle abort!
% - Set next phase in object instance, recreate model when phase is over
%
% Created by: Victor Bergelin
% Date created:
% Version number 0.01
% 0.02: better structure and always run with status 1
% 0.03: OOD on instances to better handle multiple models and methods
%
%
% Link�ping University, Link�ping


system('pwd')


%     system('module add cplex/12.5-fullampl; ampl < LNSModel_clone.run')
%     delete(close_msgbox1);
%     msgbox('Finished')
% 
%     fid = fopen('LNSModel.res','r');
%     initial_res_LNS_gui = fscanf(fid,'%s\n');
%     initial_res_LNS_gui = strrep(initial_res_LNS_gui,'current_solution=',sprintf('\n'));
%     initial_res_LNS_gui = strrep(initial_res_LNS_gui,'number_of_iterations=',sprintf('\n'));
%     initial_res_LNS_gui = strrep(initial_res_LNS_gui,'_solve_elapsed_time=',sprintf('\n'));
%     initial_res_LNS_gui = strrep(initial_res_LNS_gui,'iteration_time=',sprintf('\n'));
%     initial_res_LNS_gui = strrep(initial_res_LNS_gui,'best_solution=',sprintf('\n'));
%     result_vector_LNS = str2num(sprintf(initial_res_LNS_gui,'%s'));
%     fclose(fid);





end
