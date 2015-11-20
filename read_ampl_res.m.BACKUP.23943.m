clear;
clc;

<<<<<<< HEAD
fid = fopen('LNSModel.res','r');
v = fscanf(fid,'%s\n');
v = strrep(v,'current_solution=',sprintf('\n'));
v = strrep(v,'number_of_iterations=',sprintf('\n'));
v = strrep(v,'_solve_elapsed_time=',sprintf('\n'));
v = strrep(v,'iteration_time=',sprintf('\n'));
v = strrep(v,'best_solution=',sprintf('\n'));
x = str2num(sprintf(v,'%s'));
fclose(fid);
=======
 ampl_dir=dir('src/test/testdata/ampl_*');
         ampl_value = [];
         for i = 1:length(ampl_dir)
         ampl_value = [ampl_value; cellstr(getfield(ampl_dir,{i},'name'))];
         end

data_res = horzcat('src/test/testdata/',char(ampl_value(1)),'/');

S = char(data_res);

ampl_data_dir = dir(S);
ampl_value_2 = [];
for i = 1:length(ampl_data_dir)
ampl_value_2 = [ampl_value_2; cellstr(getfield(ampl_data_dir,{i},'name'))];
end

ampl_value_2(3);

ampl_data_name = strcat(data_res,ampl_value_2(3))
            
         
            fin = fopen('LNSModel.run','rt');
            fout = fopen('LNSModel_clone.run','wt');
            while ~feof(fin)
                   s = fgets(fin);
                   s = strrep(s, '***FILE1***', char(ampl_data_name));
                   fprintf(fout,'%s\n',s);
            end
            fclose(fin);
            fclose(fout);
>>>>>>> 0fbadfc87362f5d99eff04c332759b5ad0d34f81
