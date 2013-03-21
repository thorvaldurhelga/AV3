% getCleanedBookPoints: function to find the true book points

% Input:
% bookPoints: the point cloud of potential book points with noise

% Output:
% cleanedBookPoints: the cleaned point cloud

function cleanedBookPoints = getCleanedBookPoints(bookPoints)

cleanedBookPoints = {};

% step through each book point cloud filtering out non-book points
for i = 1:21

fig = figure(1);
clf
hold on
plot3(bookPoints{i}(:,1),bookPoints{i}(:,2),bookPoints{i}(:,3),'k.')

% Calculate the highest book point
% this will be the seed point
% the idea is that we're resonably sure that this will be a true book point
highestBookPoint = ...
	bookPoints{i}(find(bookPoints{i}(:,2)==max(bookPoints{i}(:,2))),:);

% Find the true book points
regionGrowingInput{1} = highestBookPoint;
regionGrowingInput{2} = [];
regionGrowingInput{3} = bookPoints{i};
regionGrowingInput{4} = 1;

cleaningOutput = growCleanedBookPoints(regionGrowingInput);
cleanedBookPoints{i} = cleaningOutput{2};

% plot the results
plot3(cleanedBookPoints{i}(:,1),cleanedBookPoints{i}(:,2),cleanedBookPoints{i}(:,3),'r.')
pause(1);

end

end
