clear;
clc;

fin = fopen('LNSModel.run');
fout = fopen('LNSModel_clone.run');

while ~feof(fin)
   s = fgetl(fin);
   s = strrep(s, '***FILE1***', 'DATA FÖR KÖRNING');
   fprintf(fout,'%s\n',s);
   fout = fopen('LNSModel_clone.run','w');
end

fclose(fin);
fclose(fout);