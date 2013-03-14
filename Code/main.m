load '../Data/data1.mat'
for i = 1:size(frame,2)
    edges = detectEdges(frame(i));
    lineData = extracLines(frame(i).image,edges,10,false);
end;