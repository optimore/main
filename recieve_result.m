B = dir('target/results/*_*');
value = [];
for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

p = B(end-1);
l = p.name;
temp_1=strcat('target/results/',l);
temp_2=strcat(temp_1,'/*_*');

new_path = dir(temp_2);

new_value = [];
for i = 1:length(new_path)

    new_value = [new_value; cellstr(getfield(new_path,{i},'name'))];

end

new_value

% results_2015-11-11T14-14-56