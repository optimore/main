fin = fopen('LNSModel.run','rt');
fout = fopen('LNSModel_clone.run','wt');

while ~feof(fin)
   s = fgets(fin);
   s = strrep(s, '***FILE1***', 'Hamster');
   fprintf(fout,'%s\n',s);
end
fclose(fin);
fclose(fout);