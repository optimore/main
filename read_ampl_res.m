clear;
clc;

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