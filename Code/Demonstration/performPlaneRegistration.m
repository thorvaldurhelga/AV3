% performPlaneRegistration: function to transform the book points in
% the different images so that they are aligned

% Inputs:
% bookPoints: a cell array containing a point cloud for each book
% planes: a cell array containing the plane equations from each image

function transformedPoints = performPlaneRegistration(bookPoints,transformPoints,planeEq,foundationEq)

% get the rotation matrices
[angles rotationMatrices] = findRotationMatrices(planeEq,foundationEq);

% apply the rotation to each book point cloud
rotatedBookPoints = {};
rotatedTransformPoints = {};
for i = 1:length(bookPoints)
	rotatedBookPoint = (rotationMatrices{i}*bookPoints{i}')';
    rotatedTransformPoint = (rotationMatrices{i}*transformPoints{i}')';
	rotatedBookPoints{i} = rotatedBookPoint;
    rotatedTransformPoints{i} = rotatedTransformPoint;
end

% find the mean bookpoint in each frame
meanBookPoints = {};
for i = 1:length(bookPoints)
	meanBookPoint = mean(rotatedBookPoints{i});
	meanBookPoints{i} = meanBookPoint;
end

% apply the translation to each rotated book point cloud
transformedPoints = {};
for i = 1:length(bookPoints)
	transformedPoints{i} = ...
		rotatedTransformPoints{i}- ...
		repmat(meanBookPoints{i},size(rotatedTransformPoints{i},1),1);
end

end

