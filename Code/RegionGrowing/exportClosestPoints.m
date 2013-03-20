function exportClosestPoints(closestPoints)
fid = fopen(strcat('../../Data/closestPoints.csv'),'wt');
for i=1:21
    fprintf(fid, '%d,%d,%d\n', closestPoints(i,:)');
end;
fclose(fid);