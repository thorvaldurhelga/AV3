% calculateSurfaceNormal: Function that calculates the surface normal pointing out from the plane specified by the input plane equation

function y = calculateSurfaceNormal(planeList)

%{

	%rotationMatrix = [0,-1,0;1,0,0;0,0,1];

	%normalVector = [planeList(1,1) planeList(1,2) planeList(1,3)]';
	%rotated = rotationMatrix*normalVector;

	%planeList(2,1) = rotated(1)
	%planeList(2,2) = rotated(2)
	%planeList(2,3) = rotated(3)
	%planeList(2,4) = planeList(1,4)


	%point = [1,2,3];
	%normal = [1,1,2];

	% a plane is a*x + b*y + c*z + d = 0
	% [a,b,c] is the normal, Thus, we have to calculate d and we're set
	%d = -point*normal'; % dot product for less typing

	% plane is coefficient matrix A
	% xs is the solution to unknowns
	%xs = [x y z 1]
	
	% solve for points on plane
	%zs = [0 0 0 0]';

	%[a b c d]*[x y z 1]' = [0 0 0 0]'
	
	%point = pinv(plane)	

	% create x,y
	[xx,yy]=ndgrid(1:10,1:10);


	colours = {'r.' 'g.' 'b.'};

	figure

	for i = 1:3

		a = planeList(i,1);
		b = planeList(i,2);
		c = planeList(i,3);
		d = planeList(i,4);

		i

		% calculate corresponding zs
		z = (-a*xx - b*yy - d)/c

		% draw points on the plane
		for j = 1:10
			for k = 1:10
			plot3(j,k,z(j,k),colours{i})
			hold on
			end
		end


		
		%surf(z)
		hold on

		% create normal vector
		%normalVector = [a1 b1 c1]

		% find a point on the plane - pick the midpoint for now
		%lineStartPoint = [5,5,z(5:5)]

		%for j = 1:10
		%	lineEndPoint = lineStartPoint + normalVector*j*0.5;
		%	plot3(lineEndPoint(:,1),lineEndPoint(:,2),lineEndPoint(:,3),'k.')
		%end

	end

	
	
	
	plot3(0,0,0,'r.')
	%plot(lineStartPoint,lineEndPoint)

	hold off

	y = z;

end

%}
