%findRotationMatrix: find the angle of rotation between two planes

% Inputs:
% p1: initialPlane
% p2: targetPlane

% Output:
% R: rotation matrix

function R = findRotationMatrix(p1, p2)

	% calculate normal vectors n1 and n2 for planes p1 and p2
	n1 = [p1(1) p1(2) p1(3)]'
	n2 = [p2(1) p2(2) p2(3)]'

	% the axis of rotation is the cross product of the two vectors (cross product is orthogonal to both vectors)
	axis = cross(n1,n2)

	% the normals are normalised, so the angle in radians is
	angle = acos(dot(n1,n2))

	% then we define the rotation matrix using makehgtform
	R = makehgtform('axisrotate',axis,angle)(1:3,1:3);

end
