global model planelist planenorm facelines

%%%%%%



load('data1.mat')

xyzFrame = frame(20).XYZ(:,:,:);


%backgroundIndices = find(xyzFrame > 1400);
%xyzFrame(backgroundIndices) = 0;

xyzFrame1 = xyzFrame(:,:,1); 
xyzFrame1v = xyzFrame1(:);
xyzFrame2 = xyzFrame(:,:,2);
xyzFrame2v = xyzFrame2(:);
xyzFrame3 = xyzFrame(:,:,3);
xyzFrame3v = xyzFrame3(:);

xyzImage = [xyzFrame1v xyzFrame2v xyzFrame3v];

depthThreshold = 800;

% copy image to R, leaving out all rows that are background (too far away to be of interest)
rowsToIgnore = find(xyzImage(:,3)>depthThreshold);
index = true(1,size(xyzImage,1));
index(rowsToIgnore') = false;
R2 = xyzImage(index,:);


R = R2./1;% (R2./200)-400;

figure(1)
clf
hold on
plot3(R(:,1),R(:,2),R(:,3),'k.')



%pause(100)

% now do the segmentation...


%%%%

R2 = load('rngdata.asc');





figure(1)
clf
hold on
plot3(R(:,1),R(:,2),R(:,3),'k.')


[NPts,W] = size(R);							%-- NPts = # points in the image per dimension, W = # dimensions
patchid = zeros(NPts,1);						%-- patchid = the ID of the patch each point belongs to
planelist = zeros(20,4);						%-- a list of the number of planes that we've found



% find surface patches
% here just get 5 first planes - a more intelligent process should be
% used in practice. Here we hope the 4 largest will be included in the
% 5 by virtue of their size

remaining = R;							

for i = 1 : 10   

  % select a random small surface patch from the remaining points
  [oldlist,plane] = select_patch(remaining);				%-- oldlist = ...

  % grow patch
  stillgrowing = 1;
  while stillgrowing

    % find neighbouring points that lie in plane
    stillgrowing = 0;							%-- until we find a bad fit we keep growing

    [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts);

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
else
 plot3(newlist(:,1),newlist(:,2),newlist(:,3),'m.')
 save5=newlist;
end
pause(1)
    
    if NewL > OldL + 50
      % refit plane
      [newplane,fit] = fitplane(newlist);

%	[newplane',fit,NewL];

      planelist(i,:) = newplane';
 
     if fit > 0.04*NewL       % bad fit - stop growing
        break
      end

      stillgrowing = 1;

      oldlist = newlist;
      plane = newplane;

    end
  end

%	waiting=1
%	pause(1)

['**************** Segmentation Completed']

end

%plot3(remaining(:,1),remaining(:,2),remaining(:,3),'y.')

%planelist(1:5,:)


modelfile
%planelist = [
%   0.0018   -0.0086    1.0000  179.2485
%   -0.0755    0.7003    0.7099  281.2463
%   -0.6378   -0.5599    0.5290  203.6537
%    0.7693   -0.4002    0.4979 -274.8765
%];


    pairs = zeros(100,2);
    success = itree(3,0,3,pairs,0,4);
    if success
        ['model recognised in this image']
    end
    if ~success
      ['no models recognised in this image']
    end
                                                                        

% make dataset for the practical - label points and then
% sort into numerical rather than plane order.
ulabeledpoints = zeros(NPts,4);
count = 0;
[L1,W]=size(save1);
for i = 1 : L1
  count = count + 1;
  ulabeledpoints(count,1:3) = save1(i,:);
  ulabeledpoints(count,4) = 1;
end
[L2,W]=size(save2);
for i = 1 : L2
  count = count + 1;
  ulabeledpoints(count,1:3) = save2(i,:);
  ulabeledpoints(count,4) = 2;
end
[L3,W]=size(save3);
for i = 1 : L3
  count = count + 1;
  ulabeledpoints(count,1:3) = save3(i,:);
  ulabeledpoints(count,4) = 3;
end
[L4,W]=size(save4);
for i = 1 : L4
  count = count + 1;
  ulabeledpoints(count,1:3) = save4(i,:);
  ulabeledpoints(count,4) = 4;
end
[LR,W]=size(remaining);
for i = 1 : LR
  count = count + 1;
  ulabeledpoints(count,1:3) = remaining(i,:);
  ulabeledpoints(count,4) = 5;
end

for i = 1 : count-1
for j = i+1 : count
 if ulabeledpoints(i,1) > ulabeledpoints(j,1)
   tmp = ulabeledpoints(i,:);
   ulabeledpoints(i,:) = ulabeledpoints(j,:);
   ulabeledpoints(j,:) = tmp;
 end
end
end
labeledpoints = ulabeledpoints(1:count,:);



