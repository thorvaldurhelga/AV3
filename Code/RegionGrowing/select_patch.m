% find a candidate planar patch
function [fitlist,plane] = select_patch(points)			%-- points is the list of points from which we want to select the planar patch

  [L,D] = size(points)						%-- L is the number of points, D is the number of dimensions in each point (i.e. 3...)

  tmpnew = zeros(L,3);						%-- tmpnew is a list of points representing the points in the patch
  tmprest = zeros(L,3);						%-- tmprest is a list of the remaining points

%	pointsRemaining = L

	minresid = 1000000;
	count = 0;

  % pick a random point until a successful plane is found ( where the residual error is below a certain threshold)
  success = 0;							%-- initially we haven't found a successful plane
  while ~success && count < L

	count = count+1;

    idx = count;%ceil(L*rand);				%-- idx selects the row value of a randomly selected point from the list of remaining points 
    pnt = points(idx,:);					%-- pnt is the randomly selected point itself, represented as a row vector [x y z]
  
    % find points in the neighborhood of the given point
    DISTTOL = 5.0;						%-- DISTTOL distance tolerance - how far away is still counted as in the neighbourhood?

    fitcount = 0;						%-- fitcount is the # of points found within the distance tolerance of the random point
    restcount = 0;						%-- restcount is the # of points that are not within the distance tolerance

	dists = [];




    for i = 1 : L						%-- for each remaining point...

      dist = norm(points(i,:) - pnt);				%-- dist is the euclidean distance between the current point and the random point

	dists = [dists dist];

      if dist < DISTTOL						%-- if the euclidean distance is less than the distance tolerance
        fitcount = fitcount + 1;				%-- the point fits, so we add one to the count of points included in the patch
        tmpnew(fitcount,:) = points(i,:);			%-- and add the point to the list of points included in the patch
      else
        restcount = restcount + 1;				%-- otherwise we add one to the count of points excluded from the patch
        tmprest(restcount,:) = points(i,:);			%-- and add the point to the list of excluded points
      end
    end

%	max(dists)
%	min(dists)
%	fitcount

%    oldlist = tmprest(1:restcount,:);				%-- ???

    if fitcount > 10						%-- if we have more than ten points in our patch				
      
      % fit a plane
      [plane,resid] = fitplane(tmpnew(1:fitcount,:));		%-- plane is the fitted plane, resid is the residual error


%%--- debugging code
%{
	plane
	resid
	if resid < minresid					
		minresid = resid
		count
	end 
%}


	if plane == [1 0 0 0]'					%----- check for rows that are all zeros
		['flat plane']
	elseif resid < 5 					%-- if the residual error is less than 10
        fitlist = tmpnew(1:fitcount,:);				%-- set fitlist, the list of points included in the patch to return			
        return
	else
		['no match found']
		resid
	end
      end

    end

  end  
