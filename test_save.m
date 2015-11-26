clear;
clc;

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

%-----------------------------------------------------------
fileID = fopen('testtable.dat','w');
fclose(fileID);
%-----------------------------------------------------------
a=value(end);

movefile('testtable.dat',strcat('target/results/',a{1}));

