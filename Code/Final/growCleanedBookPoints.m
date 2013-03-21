% growCleanedBookPoints: recursive function to find true book points

% Inputs:
% progress, a cell array containing:
% frontier points, cleaned points, remaining points and should continue

function output = growCleanedBookPoints(progress)

frontierPoints = progress{1};
cleanedPoints = progress{2};
remainingPoints = progress{3};
shouldContinue = progress{4};
	
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

% create the list of new frontier points
distanceThreshold = 12;
newFrontierPoints = [];
for r = 1:size(euclideanDistances,1) % for each frontier point
		
distantPoints = find(euclideanDistances(r,:)>distanceThreshold);
index = true(1,size(remainingPoints,1));
index(distantPoints') = false;

if(isempty(newFrontierPoints)) 
	newFrontierPoints = remainingPoints(index,:);
else
	newFrontierPoints = union(newFrontierPoints,remainingPoints(index,:),'rows');	
end

end

% update the variables
progress{1} = newFrontierPoints;
progress{2} = [cleanedPoints;frontierPoints];
progress{3} = setdiff(remainingPoints,newFrontierPoints,'rows');
progress{4} = 1-isempty(newFrontierPoints);

fig = figure(1);
plot3(newFrontierPoints(:,1),newFrontierPoints(:,2),newFrontierPoints(:,3),'y.');
plot3(frontierPoints(:,1),frontierPoints(:,2),frontierPoints(:,3),'b.');

pause(0.1);

if(progress{4}==1)

	progress = growCleanedBookPoints(progress);

end

output = progress;

end
