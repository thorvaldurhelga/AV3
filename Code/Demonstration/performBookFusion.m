% performBookFusion: function to perform book point fusion and plot the results

% Input:
% transformedBookPoints: a cell array containing the transformed book points
% produced by the plane registration algorithm

% Output:
% allBookPoints: a point cloud containing all of the book points, 
% scaled appropriately


function allBookPoints = performBookFusion(transformedBookPoints)

% apply the scaling to each transformed book point cloud
scaledBookPoints = {};
for i = 1:length(transformedBookPoints)
	scaledBookPoints{i} = transformedBookPoints{i}.*5;
end

% plot the results
fig = figure(2);
clf
hold on

% put all the bookpoints together
allBookPoints = [];
for i = 1:length(transformedBookPoints)
	allBookPoints = [allBookPoints;scaledBookPoints{i}];
	plot3(allBookPoints(:,1),allBookPoints(:,2),allBookPoints(:,3),'k.')
    pause(1.0);
	%saveas(fig, ...
	%	strcat('../../Images/FusedBookPoints/3D/Book', ...
	%	int2str(i),'.png'));
end

end
