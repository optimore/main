clear;
clc;

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

fileID