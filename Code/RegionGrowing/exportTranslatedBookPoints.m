function exportTranslatedBookPoints(bookPoints)
for i=1:21
    fid = fopen(strcat('../../Data/translatedBookPoints',int2str(i),'.csv'),'wt');
    fprintf(fid, '%d,%d,%d\n', bookPoints{i}');
end;
fclose(fid);
