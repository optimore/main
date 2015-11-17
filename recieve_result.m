A=dir('src/test/testdata/*_*');
value = [];
for i = 1:length(A)

    value = [value; cellstr(getfield(A,{i},'name'))];

end


dataObj.name = value(1);
    dataObj.path = horzcat('src/test/testdata/',char(1),'/');
    dataObj.path;
    dataParameters{1} = dataObj;