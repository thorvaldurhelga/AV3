% planeExtraction: code to find the largest planes for an image
% adapted from doall.m in the system 6 example code

% Input:
% pointCloud: the point cloud for the image

% Output:
% pointCloud: the original point cloud
% planeEq: the plane equation for each plane
% planePoints: the points in each plane
% closestPoints: the closest points in the image

function [planeEq planePoints closestPoints] = ...
    planeExtraction(pointCloud)

planePoints = {};       % Points on each individual plane
bookPoints = {};        % Points on the book
closestPoints = zeros(3); % Closest point in each image, i.e. the corner

plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'k.')

closestPoints = getClosestPoint(pointCloud);
plot3(closestPoints(1),closestPoints(2),3000,'r.')

[NPts,W] = size(pointCloud);	
planeEq = zeros(3,4);

remaining = pointCloud;

rightPoint = [closestPoints(1)+40 ...
    closestPoints(2)-20 closestPoints(3)+30];
leftPoint = [closestPoints(1)-40 ...
    closestPoints(2)-20 closestPoints(3)+30];
topPoint = [closestPoints(1) ...
    closestPoints(2)+20 closestPoints(3)+20];

patchPoints = [rightPoint; leftPoint; topPoint]
plot3(rightPoint(:,1),rightPoint(:,2),3000,'b.')
plot3(leftPoint(:,1),leftPoint(:,2),3000,'g.')
plot3(topPoint(:,1),topPoint(:,2),3000,'y.')

for i = 1 : 3 
    planePatch = getClosestPointToPoint(pointCloud,patchPoints(i,:))

    % select a random small surface patch from the remaining points
    [oldlist,plane] = select_patches(remaining,planePatch);

    plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3),'y.')

    % grow patch

    growthCycles=0;

    stillgrowing = 1;

    while stillgrowing

        growthCycles = growthCycles+1

        stillgrowing = 0; %-- until we find a bad fit we keep growing

        [newlist,remaining] = ...
            getallpoints(plane,oldlist,remaining,NPts);

        [NewL,W] = size(newlist);
        [OldL,W] = size(oldlist);

        if i == 1
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')
            save1=newlist;
        elseif i==2 
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'b.')
            save2=newlist;
        else
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'g.')
            save3=newlist;
        end
        pause(0.01)

        if NewL > OldL + 50
            ['refitting plane']

            % refit plane
            [newplane,fit] = fitplane(newlist);
            planeEq(i,:) = newplane';
            fitThreshold = 0.3;

            if fit > fitThreshold*NewL   % bad fit - stop growing
                break
            end

            stillgrowing = 1;
            oldlist = newlist;
            plane = newplane;
        end  
    end

    ['**************** Segmentation Completed']

    planePoints{i} = oldlist;
end
