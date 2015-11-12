clear;
clc;

A=dir('src/test/testdata/*_*');
test_data_value = [];
for i = 1:length(A)

    test_data_value = [test_data_value; cellstr(getfield(A,{i},'name'))];

end



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

new_value=[];
for i = 1:length(new_path)

    new_value = [new_value; cellstr(getfield(new_path,{i},'name'))];

end



new_value_name = new_value;



temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_value(1));
    temp_path = sprintf('%s',temp_2{:});
    load_data = load(temp_path);
    




for new_val_it = 1:length(new_value)
    new_value_temp_1 = strrep(new_value(new_val_it),'result_',' ');
    
    temp_number =  strrep(new_value_temp_1,num2str(new_val_it),' ');
    
    new_value_temp_2 = strrep(temp_number,'_',' ');
    new_value_name(new_val_it) = new_value_temp_2;

end
 
for iter_1 = 1:length(new_value)
    
    temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_value(iter_1));
    temp_path = sprintf('%s',temp_2{:});
    
    temp_load = load(temp_path);
    
    max_iter(iter_1) = temp_load(end-1,1);
    
    max_cost(iter_1) = temp_load(end-1,2);
    
    max_time(iter_1) = temp_load(end-1,3);
   
end

for iter_2 = 1:length(new_value)
    
    data_table = [test_data_value(iter_2),new_value_name(iter_2),max_iter(iter_2),max_cost(iter_2),max_time(iter_2)]

end


