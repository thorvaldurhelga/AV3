% getMeanBookPoints: returns a point whose co-ordinates are
% the mean of the co-ordinates of all the book points in each image

% Input:
% bookPoints: a set of book points for each image

% Output:
% meanBookPoints: a cell array containing the mean book point
% for each image

function meanBookPoints = getMeanBookPoints(bookPoints)

	% find the mean bookpoint in each frame
	meanBookPoints = {};
	for i = 1:21
		meanBookPoint = mean(bookPoints{i});
		meanBookPoints{i} = meanBookPoint;
	end

end
