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
for i = 1:21
	scaledBookPoints{i} = transformedBookPoints{i}.*5;
end

% plot the results
fig = figure(1);
clf
hold on

% put all the bookpoints together
allBookPoints = [];
for i = 1:21
	allBookPoints = [allBookPoints;scaledBookPoints{i}];
	plot3(allBookPoints(:,1),allBookPoints(:,2),allBookPoints(:,3),'k.')
	saveas(fig, ...
		strcat('../../Images/FusedBookPoints/3D/Book',int2str(i),'.png'));
end

end
