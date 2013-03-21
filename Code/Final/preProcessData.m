% preProcessData: function to pre-process the raw range data from a frame, 
% creating a 3D point cloud that can be used with the region growing algorithm

% Input:
% frame: a single frame from the input data

% Output:
% pointCloud: a preprocessed point cloud representing the frame

function pointCloud = preProcessData(frame)

	planePoints = {};       % Points on each individual plane
	bookPoints = {};        % Points on the book
	closestPoints = zeros(3); % Closest point in each image


	% Convert the frame into a 3D point cloud
	xyzFrame = frame.XYZ(:,:,:);
	xFrame = xyzFrame(:,:,1); 
	xFrame = xFrame(:);
	yFrame = xyzFrame(:,:,2);
	yFrame = yFrame(:);
	zFrame = xyzFrame(:,:,3);
	zFrame = zFrame(:);
	pointCloud = [xFrame yFrame zFrame];

	% Clean and normalise the point cloud
	% - Remove all points further away than the depth threshold
	% - Remove all points whose co-ordinates are (0,0,0)
	% - Divide the points by 5
	depthThreshold = 1400;
	backgroundRowsToIgnore = find(pointCloud(:,3)>depthThreshold);
	zeroRowsToIgnore = find(abs(pointCloud(:,1)) + ...
	    abs(pointCloud(:,2)) + abs(pointCloud(:,3))==0);
	index = true(1,size(pointCloud,1));
	index(backgroundRowsToIgnore') = false;
	index(zeroRowsToIgnore') = false;
	pointCloud = pointCloud(index,:)./5;

end

