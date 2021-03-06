% plotBookPoints: 

function y = plotBookPoints(bookPoints,planes)

	% clean up the bookpoints
	cleanedBookPoints = getCleanedBookPoints(bookPoints);

	% get the rotation matrices
	rotationMatrices = findRotationMatrices(planes);

	% apply the rotation to each frame
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

	% apply the translation to each book point cloud
	translatedBookPoints = {};
	for i = 1:21
		translatedBookPoints{i} = rotatedBookPoints{i}-repmat(meanBookPoints{i},size(rotatedBookPoints{i},1),1);
	end

	% put all the bookpoints together
	allBookPoints = [];
	for i = 1:21
		allBookPoints = [allBookPoints;translatedBookPoints{i}];
	end

	% plot the results
	fig = figure(1);
	clf
	hold on
	plot3(allBookPoints(:,1),allBookPoints(:,2),allBookPoints(:,3),'k.')

end
