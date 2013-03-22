% getCleanedBookPoints: function to find the true book points

% Input:
% bookPoints: the point cloud of potential book points with noise

% Output:
% cleanedBookPoints: the cleaned point cloud

function cleanedBookPoints = getCleanedBookPoints(bookPoints)

cleanedBookPoints = {};

% step through each book point cloud filtering out non-book points

fig = figure(1);
clf
hold on
plot3(bookPoints(:,1),bookPoints(:,2),bookPoints(:,3),'k.')

% Calculate the highest book point
% this will be the seed point
% the idea is that we're resonably sure that this will be a true book point
highestBookPoint = ...
	bookPoints(find(bookPoints(:,2)==max(bookPoints(:,2))),:);

% Find the true book points
regionGrowingInput{1} = highestBookPoint;
regionGrowingInput{2} = [];
regionGrowingInput{3} = bookPoints;
regionGrowingInput{4} = 1;

cleaningOutput = growCleanedBookPoints(regionGrowingInput);
cleanedBookPoints = cleaningOutput{2};

% plot the results
plot3(cleanedBookPoints(:,1),...
	cleanedBookPoints(:,2),cleanedBookPoints(:,3),'r.')
pause(1);


end
