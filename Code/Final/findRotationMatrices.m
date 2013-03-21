% findRotationMatrices: find the rotation matrices for the planes

% Inputs:
% planes: the plane list

% Output:
% rotationMatrices: rotation matrices

function rotationMatrices = findRotationMatrices(planes)

% the top plane from image number 17 is our reference plane
p2 = planes(1,:,17);

% get the rotation matrix for each frame
rotationMatrices = {};
for i = 1:21
	
p1 = planes(1,:,i);
	
% calculate normal vectors n1 and n2 for planes p1 and p2
n1 = [p1(1) p1(2) p1(3)]';
n2 = [p2(1) p2(2) p2(3)]';
	
% the axis of rotation is the cross product of the two vectors 
% (cross product is orthogonal to both vectors)
axis = cross(n1,n2);
	
% the normals are normalised, so the angle in radians is
angle = acos(dot(n1,n2));
	
% then we define the rotation matrix using makehgtform
R = makehgtform('axisrotate',axis,angle);
	
% if it's the reference frame we just use the identity matrix for the rotation, 
% otherwise use R
if (i==17)
	rotationMatrices{i} = eye(3); 
else
	rotationMatrices{i} = R(1:3,1:3);
end
	
end

end
