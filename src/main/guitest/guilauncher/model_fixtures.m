dataParameters = struct('name',{},'path',{});
DataDir=dir('src/test/testdata/*_*');
pathname = [];
filename = [];
for i = 1:length(pathname)
    pathname = [pathname; cellstr(getfield(DataDir,{i},'name'))];
    filename = [filename; 'Name'];
end

for i = 1:length(filename)
   
    dataObj.name = filename(i);
    dataObj.path = ['src/test/testdata/',pathname(i)];
    dataParameters{i} = dataObj; 
    
end