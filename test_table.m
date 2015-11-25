clear;
clc;

B = dir('target/results/results_201*');
value = [];

for i = 1:length(B)

    value = [value; cellstr(getfield(B,{i},'name'))];

end

p = B(end);
l_path_gui = p.name;
temp_1=strcat('target/results/',l_path_gui);
temp_2=strcat(temp_1,'/*_*');

new_path = dir(temp_2);

new_value=[];
for i = 1:length(new_path)

    new_value = [new_value; cellstr(getfield(new_path,{i},'name'))];

end

new_value_name = new_value;

for new_val_it = 1:length(new_value)
    new_value_temp_1 = strrep(new_value(new_val_it),'result_',' ');
    
    temp_number =  strrep(new_value_temp_1,num2str(new_val_it),' ');
    
    new_value_temp_2 = strrep(temp_number,'_',' ');
    new_value_name(new_val_it) = new_value_temp_2;

end

s = char(new_value);

% Skapa en vektor, som för varje element 
j=1;
a=[1];

for i = 1:length(new_value)-1
    
    
    b = s(i,3:1:5)==s(i+1,3:1:5);
   
    if and(and(b(1),b(2)),b(3))==1 %kuksnopp
        a(j) = a(j) + 1;
        c=a;
%         if i==length(new_value)-1
%            a(j) = a(j) + 1;
%            d=a
%            end
    elseif and(and(b(1),b(2)),b(3))==0
        a = [a 0];
        e=a;
        j=j+1;
        a(j)=1;
    end
end

a;

% UNTITLED3 Summary of this function goes here
% sample är massa test resultatsstruckar
% a är a streck på whiteboarden
%   Detailed explanation goes here
    
% for i=1:length(a)
%     %en för iteration mean
%     %en för time mean
%     %en för iteration standardavikelse
%     %en för iteration standardavikelse
%     %en för iteration max
%     %en för iteration min
%     %en för time max
%     %en för time min
%     %en för failure kvot
%     meaniteration(i)=mean(temp_load(l:l-1+a(i),1));
%     meantime(i)=mean(temp_load(l:l-1+a(i),3));
%     iterationstandarddeviation(i)=std(temp_load(l:l-1+a(i),1));
%     timestandarddeviation(i)=std(temp_load(l:l-1+a(i),3));
%     iterationmax(i)=max(temp_load(l:l-1+a(i),1));
%     timemax(i)=max(temp_load(l:l-1+a(i),3));
%     iterationmin(i)=min(temp_load(l:l-1+a(i),1));
%     timemin(i)=min(temp_load(l:l-1+a(i),3));
%     failurekvot(i)=(a(i)-sum(temp_load(l:l-1+a(i))==0,2))/a(i);
% %     s=(a(i)-sum(temp_load(l:l-1+a(i))==0))/a(i)
%     l=l+a(i);
%    
% end

