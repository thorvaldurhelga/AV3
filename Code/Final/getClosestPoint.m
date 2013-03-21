% gets the closest point in the image
function meanClosestPoint = getClosestPoint(pointCloud)
minDepth = min(pointCloud(:,3))
minDepthIndex = find(pointCloud(:,3)==minDepth)
closestPoints = pointCloud(minDepthIndex,:)
meanClosestPoint = mean(closestPoints)





     
