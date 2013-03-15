% find a candidate planar patch
function [fitlist,plane] = select_patch(points)			%-- points is the list of points from which we want to select the planar patch

  [L,D] = size(points);						%-- L is the number of points, D is the number of dimensions in each point (i.e. 3...)

  tmpnew = zeros(L,3);						%-- tmpnew is ...
  tmprest = zeros(L,3);						%-- tmprest is ...

	pointsRemaining = L

  % pick a random point until a successful plane is found
  success = 0;							%-- initially we haven't found a successful plane
  while ~success
    idx = floor(L*rand);					%-- the index
    pnt = points(idx,:);
  
    % find points in the neighborhood of the given point
    DISTTOL = 5.0;
    fitcount = 0;
    restcount = 0;
    for i = 1 : L
      dist = norm(points(i,:) - pnt);
      if dist < DISTTOL
        fitcount = fitcount + 1;
        tmpnew(fitcount,:) = points(i,:);
      else
        restcount = restcount + 1;
        tmprest(restcount,:) = points(i,:);
      end
    end
    oldlist = tmprest(1:restcount,:);

    if fitcount > 10
      % fit a plane
      [plane,resid] = fitplane(tmpnew(1:fitcount,:));

      if resid < 0.1
        fitlist = tmpnew(1:fitcount,:);
        return
      end
    end
  end  
