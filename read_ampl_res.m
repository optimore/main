clear;
clc;

fid = fopen('LNSModel.res','r');
v = fscanf(fid,'%s\n');
v = strrep(v,'current_solution=',sprintf('\n'));
v = strrep(v,'number_of_iterations=',sprintf('\n'));
v = strrep(v,'_solve_elapsed_time=',sprintf('\n'));
v = strrep(v,'iteration_time=',sprintf('\n'));
v = strrep(v,'best_solution=',sprintf('\n'));
x = str2num(sprintf(v,'%s'));
fclose(fid);