% growCleanedBookPoints:

function progess = growCleanedBookPoints(progress)

	frontierPoints = progress{1}
	cleanedPoints = progress{2};
	remainingPoints = progress{3};
	shouldContinue = progress{4};

	%newFrontierPoints = [];

	%for i = 1:size(frontierPoints,1)
	%	frontierPoint = frontierPoints(1,:);
	%	frontierPointsToAdd = arrayFun(@findNearbyPoints(frontierPoint,remainingPoints));
	%end;
	
	%frontierPointsToAdd
	
%%	distances = pdist2(frontierPoints,remainingPoints);

%%	size(distances)
	
	X = frontierPoints;
	Y = remainingPoints;

	% next 5 lines are from Piotr Dollar's toolbox
	% http://vision.ucsd.edu/~pdollar/toolbox/doc/index.html
	% The code calculates the pairwise squared euclidean distance between the rows of X and Y
	m = size(X,1);
	n = size(Y,1);
	XX = sum(X.*X,2);
	YY = sum(Y'.*Y',1);
	D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*Y';

	% calculate the euclidean distances
	euclideanDistances = sqrt(D);

	numberOfRows = 	size(euclideanDistances)

		
	distantPoints = find(euclideanDistances(:,3)>depthThreshold);
	zeroRowsToIgnore = find(abs(xyzImage(:,1))+abs(xyzImage(:,2))+abs(xyzImage(:,3))==0);

	index = true(1,size(xyzImage,1));
	index(backgroundRowsToIgnore') = false;
	index(zeroRowsToIgnore') = false;

	R = xyzImage(index,:)./5;	

	progress{1} = frontierPoints;
	progress{2} = cleanedPoints;
	progress{3} = remainingPoints;
	progress{4} = shouldContinue;


end
