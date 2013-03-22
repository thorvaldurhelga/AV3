% performBookFusion: function to perform book point fusion and plot the results

% Input:
% transformedBookPoints: a cell array containing the transformed book points
% produced by the plane registration algorithm

% Output:
% allBookPoints: a point cloud containing all of the book points, 
% scaled appropriately


function allBookPoints = performPlaneFusion(transformedPlanePoints)

colours = {'r.' 'b.' 'g.'}

fig = figure(3);
clf
hold on

for i = 1:length(transformedPlanePoints{2})
    leftPlanePoints = transformedPlanePoints{2}{i};
    leftRowsToIgnore = find(leftPlanePoints(:,1) < -100);
    index = true(1,size(leftPlanePoints,1));
    index(leftRowsToIgnore') = false;
    transformedPlanePoints{2}{i} = leftPlanePoints(index,:);
end;

for j = 1:3
    transformedBookPoints = transformedPlanePoints{j};
    
    % apply the scaling to each transformed book point cloud
    scaledBookPoints = {};
    for i = 1:length(transformedBookPoints)
        scaledBookPoints{i} = transformedBookPoints{i}.*5;
    end

    % plot the results
    

    % put all the bookpoints together
    allBookPoints = [];
    for i = 1:length(transformedBookPoints)
        allBookPoints = [allBookPoints;scaledBookPoints{i}];
        plot3(allBookPoints(:,1),allBookPoints(:,2),allBookPoints(:,3),colours{j})
        hold on;
        pause(1.0);
        %saveas(fig, ...
        %	strcat('../../Images/FusedBookPoints/3D/Book', ...
        %	int2str(i),'.png'));
    end

end
