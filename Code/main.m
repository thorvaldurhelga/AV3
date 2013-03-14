load '../Data/data1.mat'
allEdges = {};
lineData = {};
for i = 1:21
    bwimage = rgb2gray(frame(i).image);
	edges = edge(bwimage,'canny',[0.0124,0.0624],2.5);
    edges(:,1:100) = 0;
	edges(:,590:640) = 0;
	backgroundIndices = find(frame(i).XYZ(:,:,3) > 1400);
	edges(backgroundIndices) = 0;

    allEdges{i} = edges;
    figure(1);
    imshow(allEdges{i});
    lineData{i} = extractLines(frame(i).image,allEdges{i},10,true);
end;
