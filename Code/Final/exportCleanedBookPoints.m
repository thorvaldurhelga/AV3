function exportCleanedBookPoints(bookPoints)
for i=1:21
    fid = fopen(strcat('../../Data/cleanedBookPoints',int2str(i),'.csv'),'wt');
    fprintf(fid, '%d,%d,%d\n', bookPoints{i}');
end;
fclose(fid);
