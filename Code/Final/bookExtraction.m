function bookPoints = ...
       bookExtraction(pointCloud,planeEq,planePoints,closestPoints)

% subtract points in R that are on planes 
allPoints = [planePoints{1};planePoints{2};planePoints{3}];
[~,planeRowsToIgnore] = ismember(allPoints,pointCloud,'rows');
planeRowsToIgnore(find(planeRowsToIgnore > 0));

planeIndex = true(1,size(pointCloud,1));
planeIndex(planeRowsToIgnore') = false;
reducedPointCloud = pointCloud(planeIndex,:,:);

% subtract points too low / to left / to right of planes
minXPoint = min(planePoints{3}(:,1));
maxXPoint = max(planePoints{3}(:,1));
bookPoints = reducedPointCloud(find( ...
    (reducedPointCloud(:,1) > minXPoint) & ...
    (reducedPointCloud(:,1) < maxXPoint) & ...
    (reducedPointCloud(:,2) > closestPoints(2))),:);

% Get points above top plane
[abovePoints aboveIndices] = ...
    getPointsAbovePlane(bookPoints,planeEq(3,:));
bookPoints = bookPoints(aboveIndices,:);
plot3(bookPoints(:,1), bookPoints(:,2),bookPoints(:,3),'y.');
pause(0.01);
% saveas(fig,strcat('../../Images/BookExtraction3/',int2str(frameNo)),'png');