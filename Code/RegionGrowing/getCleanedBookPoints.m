% getCleanedBookPoints:

function cleanedBookPoints = getCleanedBookPoints(bookPoints,remainingPoints)

	fig = figure(1);
	clf
	hold on
	plot3(bookPoints(:,1),bookPoints(:,2),bookPoints(:,3),'k.')


	









	cleanedBookPoints = bookPoints;

	plot3(cleanedBookPoints(:,1),cleanedBookPoints(:,2),cleanedBookPoints(:,3),'y.')


end
