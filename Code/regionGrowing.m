load('../Data/data1.mat')

xyzFrame = frame(20).XYZ(:,:,:);

backgroundIndices = find(xyzFrame > 1400);
xyzFrame(backgroundIndices) = 0;

xyzFrame1 = xyzFrame(:,:,1);
xyzFrame1v = xyzFrame1(:);
xyzFrame2 = xyzFrame(:,:,2);
xyzFrame2v = xyzFrame2(:);
xyzFrame3 = xyzFrame(:,:,3);
xyzFrame3v = xyzFrame3(:);

xyzImage = [xyzFrame1v xyzFrame2v xyzFrame3v];

R = xyzImage







%R = zFrame
%figure(1)
%clf
%hold on
%plot3(R(:,:,1),R(:,:,2),R(:,:,3),'k.')



%[rows,columns] = size(zFrame);

%patchID = zeros(rows,1);

%planelist = zeros(20,4);







