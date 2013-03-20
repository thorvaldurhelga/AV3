global model planelist planenorm facelines

load('../../Data/data1.mat')

planes = zeros(3,4,21); % Contains plane equations of the three planes extracted
pointLists = {};        % Contains the points of all three planes extracted
bookPoints = {};        % Contains the points of the book
cornerPoints = zeros(21,3);
closestPoints = zeros(21,3);
pointsOnPlane = {};

for q = 1:21
    pointLists{q} = [];
q
xyzFrame = frame(q).XYZ(:,:,:);

xyzFrame1 = xyzFrame(:,:,1); 
xyzFrame1v = xyzFrame1(:);
xyzFrame2 = xyzFrame(:,:,2);
xyzFrame2v = xyzFrame2(:);
xyzFrame3 = xyzFrame(:,:,3);
xyzFrame3v = xyzFrame3(:);

img = [xyzFrame1v xyzFrame2v xyzFrame3v];

xyzImage = img(randperm(size(img,1)),:);

depthThreshold = 1400;

backgroundRowsToIgnore = find(xyzImage(:,3)>depthThreshold);
zeroRowsToIgnore = find(abs(xyzImage(:,1))+abs(xyzImage(:,2))+abs(xyzImage(:,3))==0);

index = true(1,size(xyzImage,1));
index(backgroundRowsToIgnore') = false;
index(zeroRowsToIgnore') = false;

R = xyzImage(index,:)./5;

fig = figure(1);
clf
hold on
plot3(R(:,1),R(:,2),R(:,3),'k.')

closestPoints(q,:) = getClosestPoint(R);
plot3(closestPoints(q,1),closestPoints(q,2),3000,'r.')

[NPts,W] = size(R);							%-- NPts = # points in the image per dimension, W = # dimensions
patchid = zeros(NPts,1);						%-- patchid = the ID of the patch each point belongs to
planelist = zeros(3,4);						%-- a list of the number of planes that we've found

% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size

remaining = R;

rightPoint = [closestPoints(q,1)+40 closestPoints(q,2)-20 closestPoints(q,3)+30];
leftPoint = [closestPoints(q,1)-40 closestPoints(q,2)-20 closestPoints(q,3)+30];
topPoint = [closestPoints(q,1) closestPoints(q,2)+20 closestPoints(q,3)+20];

planePoints = [rightPoint; leftPoint; topPoint]
plot3(rightPoint(:,1),rightPoint(:,2),3000,'b.')
hold on
plot3(leftPoint(:,1),leftPoint(:,2),3000,'g.')
hold on
plot3(topPoint(:,1),topPoint(:,2),3000,'y.')
hold on


for i = 1 : 3 
   
	l = length(R(:,1));
    
    pnt = getClosestPointToPoint(R,planePoints(i,:))

    % select a random small surface patch from the remaining points
    [oldlist,plane] = select_patches(remaining,pnt);	%-- oldlist is the list of points in the patch, plane is the best fit for the patch

	plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3),'y.')

    waiting = 1
    pause(1)

    % grow patch
  
	growthCycles=0;

    stillgrowing = 1;
    
    while stillgrowing

        growthCycles = growthCycles+1

        % find neighbouring points that lie in plane

        stillgrowing = 0;							%-- until we find a bad fit we keep growing

        [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts);

        size(remaining)

    	[NewL,W] = size(newlist);
    	[OldL,W] = size(oldlist);


        if i == 1
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')
            save1=newlist;
        elseif i==2 
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'b.')
            save2=newlist;
        elseif i == 3
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'g.')
            save3=newlist;
        elseif i == 4
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'c.')
            save4=newlist;
        elseif i == 5
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'m.')
            save5=newlist;
        else
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'y.')
            save6=newlist;
        end
        pause(1)

        NewL
        OldL

    	if NewL > OldL + 50
            ['refitting plane']

            % refit plane
            [newplane,fit] = fitplane(newlist);
            planelist(i,:) = newplane';
 
            fit

            fitThreshold = 0.3;

            if fit > fitThreshold*NewL       % bad fit - stop growing
                break
            end

            stillgrowing = 1;

            oldlist = newlist;
            plane = newplane;
        end  
    end

	waiting=1
	pause(1)

    ['**************** Segmentation Completed']
        
    pointLists{q} = [pointLists{q};oldlist];
    pointsOnPlane{i} = oldlist;
    
end

planes(:,:,q) = planelist;

% subtract points in R that are on planes 
[~,planeRowsToIgnore]=ismember(pointLists{q},R,'rows');
planeRowsToIgnore(find(planeRowsToIgnore > 0));

planeIndex = true(1,size(R,1));
planeIndex(planeRowsToIgnore') = false;
R_minus_plane_points = R(planeIndex,:,:);

% subtract points too low / to left / to right of planes
minXPoint = min(pointsOnPlane{3}(:,1));
maxXPoint = max(pointsOnPlane{3}(:,1));
bookPoints{q} = R_minus_plane_points(find( ...
    (R_minus_plane_points(:,1) > minXPoint) & ...
    (R_minus_plane_points(:,1) < maxXPoint) & ...
    (R_minus_plane_points(:,2) > closestPoints(q,2))),:);

% Get points above top plane
[abovePoints aboveIndices] = getPointsAbovePlane(bookPoints{q},planes(3,:,q));
bookPoints{q} = bookPoints{q}(aboveIndices,:);
plot3(bookPoints{q}(:,1),bookPoints{q}(:,2),bookPoints{q}(:,3),'y.');
    
%saveas(fig,strcat('../../Images/BookExtraction3/',int2str(q)),'png');

end;

