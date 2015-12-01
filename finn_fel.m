clear;
clc;

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

p = B(end);
l = p.name;
temp_1=strcat('target/results/',l);
temp_2=strcat(temp_1,'/*_*');

new_path = dir(temp_2);

past_value=[];
for i = 1:length(new_path)

    past_value = [past_value; cellstr(getfield(new_path,{i},'name'))];

end

new_past_value=[];
for i=1:length(past_value)
    
    b = past_value(i);
    c = b{1};
    
    if or(or(c(1)=='T',c(1)=='L'),c(1)=='A')==1
        new_past_value=[past_value(i) new_past_value];
    else
        new_past_value = new_past_value;
    end
end

 temp_1=strcat('target/results/',l);
    temp_2=strcat(temp_1,'/',new_past_value);
    temp_path = sprintf('%s',temp_2{:});

load_data = load(temp_path);
    for p = 1:length(load_data(:,2))
    
        
        if load_data(p,2)==0
            ln_data_1(p)=0;
        else
        ln_data_1(p)=log(load_data(p,2));
        end
    end
    
        
   for p = 1:length(load_data(:,4))
    
        if load_data(p,2)==0
            ln_data_2(p)=0;
        else
        ln_data_2(p)=log(load_data(p,4));
        end
   end
    
       
        
        
    
     
        