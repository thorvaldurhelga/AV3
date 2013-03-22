% findRotationMatrices: find the rotation matrices for the planes

% Inputs:
% planes: the plane list

% Output:
% angles: angles between the surface normals
% rotationMatrices: rotation matrices for the planes

function [angles rotationMatrices] = findRotationMatrices(planeEq,foundationEq)

% the top plane from image number 17 is our reference plane
p2 = foundationEq(1,:);

% get the angle and rotation matrix for each frame
angles = {};
rotationMatrices = {};

for i = 1:size(planeEq,3)
	
p1 = planeEq(1,:,i);
	
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
rotationMatrices{i} = R(1:3,1:3);
angles{i} = angle;
	
end

end
