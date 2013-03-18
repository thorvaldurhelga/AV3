% gets the closest point in the point cloud to the point given as input
function closestPoint = getClosestPointToPoint(pointCloud, point)

distancesFromPoint = [];

l = length(pointCloud(:,1));

dist = abs(pointCloud(:,1)-point(1))+abs(pointCloud(:,2)-point(2))+abs(pointCloud(:,3)-point(3));

closestIndex = find(dist==min(dist))

closestPoint = pointCloud(closestIndex(1),:);





     
