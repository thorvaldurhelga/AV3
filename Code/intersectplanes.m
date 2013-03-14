% computes the 3D line with direction d thru point a given
% 3D planes x*nl' + bl = 0 and x*nr' + br = 0 
function [d,a] = intersectplanes(nl,bl,nr,br)
  d = cross(nl,nr);
  d = d / norm(d);
  M=zeros(3,3);
  M(1,:) = d;
  M(2,:) = nl;
  M(3,:) = nr;
  b=zeros(3,1);
  b(2) = -bl;
  b(3) = -br;
  a = (inv(M)*b)';

