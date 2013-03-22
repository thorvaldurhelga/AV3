% getPointsAbovePlane: function to find the points within
% a certain distance of the specified plane

function [points indices] = getPointsAbovePlane(R,plane)
R = [R ones(size(R,1),1)];
distanceFromPlane = R*plane';
distanceTolerance = -1;
indices = find(distanceFromPlane <= distanceTolerance);
points = R(indices);