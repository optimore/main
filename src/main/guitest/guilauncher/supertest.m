clear;
clc;

A=dir('src/test/testdata/*_*');
value = [];
for i = 1:2

    value = [value; cellstr(getfield(A,{i},'name'))]

end

% Kan användas för listboxen.
% a = get(handles.listbox1,'Value');
% if(a==1)
%     set(handles.text2,'String',strrep(value(1),'A1_2015-10-30T11-14-11','A1'));
% else(a==2)
%     set(handles.text2,'String',strrep(value(2),'A2_2015-10-30T15-14-12','A2'));
% end