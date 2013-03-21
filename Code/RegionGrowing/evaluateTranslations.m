% evaluateTranslations:

function output = evaluateTranslations(closestPoints,bookPoints)

	% get the mean of all of the book points for each image
	meanBookPoints = getMeanBookPoints(bookPoints);

	% go through each of the frames applying the mean book point translation to the closest point
	translatedPoints = {};
	for i = 1:21
		translatedPoints{i} = closestPoints(i,:)-meanBookPoints{i};
	end

	% subtract the closest point from the foundation image from the others
	foundationPoint = translatedPoints{17};
	subtractedPoints = [];
	for i = [1:16 18:21]
		subtractedPoints = [subtractedPoints;translatedPoints{i}-foundationPoint];
	end

	% Compute the evaluation statistics
	covarianceMatrix = cov(subtractedPoints')
	determinantOfCovarianceMatrix = det(covarianceMatrix)

	output = {};
	output{1} = covarianceMatrix;
	output{2} = determinantOfCovarianceMatrix;

end
