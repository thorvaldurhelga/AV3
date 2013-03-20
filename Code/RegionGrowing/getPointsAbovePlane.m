function [points indices] = getPointsAbovePlane(R,plane)
R = [R ones(size(R,1),1)];
distanceFromPlane = R*plane';
distanceTolerance = -1;
indices = find(distanceFromPlane <= distanceTolerance);
points = R(indices);