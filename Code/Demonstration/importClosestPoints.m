function closestPoints = importClosestPoints()
closestPoints = zeros(21,3);
for i=1:21
    closestPoints(i,:) = csvread('../../Data/closestPoints.csv',(i-1),0,[(i-1),0,(i-1),2]);
end;