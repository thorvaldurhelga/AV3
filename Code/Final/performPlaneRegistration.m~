% performPlaneRegistration: function to transform the book points in
% the different images so that they are aligned

% Inputs:
% bookPoints: a cell array containing a point cloud for each book
% planes: a cell array containing the plane equations from each image

function transformedBookPoints = performPlaneRegistration(bookPoints,planes)

% get the rotation matrices
rotationMatrices = findRotationMatrices(planes);

% apply the rotation to each book point cloud
rotatedBookPoints = {};
for i = 1:21
	rotatedBookPoint = (rotationMatrices{i}*cleanedBookPoints{i}')';
	rotatedBookPoints{i} = rotatedBookPoint;
end

% find the mean bookpoint in each frame
meanBookPoints = {};
for i = 1:21
	meanBookPoint = mean(rotatedBookPoints{i});
	meanBookPoints{i} = meanBookPoint;
end

% apply the translation to each rotated book point cloud
transformedBookPoints = {};
for i = 1:21
	transformedBookPoints{i} = ...
		rotatedBookPoints{i}- ...
		repmat(meanBookPoints{i},size(rotatedBookPoints{i},1),1);
end

end

