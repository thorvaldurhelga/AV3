% calculateSurfaceNormal: Function that calculates the surface normal pointing out from the plane specified by the input plane equation

function y = calculateSurfaceNormal(plane)

	%point = [1,2,3];
	%normal = [1,1,2];

	% a plane is a*x + b*y + c*z + d = 0
	% [a,b,c] is the normal, Thus, we have to calculate d and we're set
	%d = -point*normal'; % dot product for less typing


	a = plane(1);
	b = plane(2);
	c = plane(3);
	d = plane(4);


	% create x,y
	[xx,yy]=ndgrid(1:10,1:10);


	% calculate corresponding z
	z = (-a*xx - b*yy)/c;

	% draw the plane
	figure
	surf(z)

	y = plane;



end
