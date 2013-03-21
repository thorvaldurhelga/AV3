% getMeanBookPoints

function meanBookPoints = getMeanBookPoints(bookPoints)

	% find the mean bookpoint in each frame
	meanBookPoints = {};
	for i = 1:21
		meanBookPoint = mean(bookPoints{i});
		meanBookPoints{i} = meanBookPoint;
	end

end