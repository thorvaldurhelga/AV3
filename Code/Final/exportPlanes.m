function exportPlanes(planes)
fid = fopen('../../Data/planeEq.csv','wt');
for i=1:21
    fprintf(fid, '%d,%d,%d,%d\n', planes(:,:,i)');
end;
fclose(fid);