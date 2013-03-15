% find a candidate planar patch
function [fitlist,plane] = select_patch(points)			%-- points is the list of points from which we want to select the planar patch

  [L,D] = size(points);						%-- L is the number of points, D is the number of dimensions in each point (i.e. 3...)

  tmpnew = zeros(L,3);						%-- tmpnew is a list of points representing the points in the patch
  tmprest = zeros(L,3);						%-- tmprest is a list of the remaining points

%	pointsRemaining = L

  % pick a random point until a successful plane is found
  success = 0;							%-- initially we haven't found a successful plane
  while ~success

    idx = ceil(L*rand);						%-- idx selects the row value of a randomly selected point from the list of remaining points 
    pnt = points(idx,:);					%-- pnt is the randomly selected point itself, represented as a row vector [x y z]
  
    % find points in the neighborhood of the given point
    DISTTOL = 5.0;						%-- DISTTOL distance tolerance - how far away is still counted as in the neighbourhood?

    fitcount = 0;						%-- fitcount is the # of points found within the distance tolerance of the random point
    restcount = 0;						%-- restcount is the # of points that are not within the distance tolerance

    for i = 1 : L						%-- for each remaining point...

      dist = norm(points(i,:) - pnt);				%-- dist is the euclidean distance between the current point and the random point

      if dist < DISTTOL						%-- if the euclidean distance is less than the distance tolerance
        fitcount = fitcount + 1;				%-- the point fits, so we add one to the count of points included in the patch
        tmpnew(fitcount,:) = points(i,:);			%-- and add the point to the list of points included in the patch
      else
        restcount = restcount + 1;				%-- otherwise we add one to the count of points excluded from the patch
        tmprest(restcount,:) = points(i,:);			%-- and add the point to the list of excluded points
      end
    end

%    oldlist = tmprest(1:restcount,:);				%-- ???

    if fitcount > 10
      % fit a plane
      [plane,resid] = fitplane(tmpnew(1:fitcount,:));

      if resid < 0.1
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
  end  
