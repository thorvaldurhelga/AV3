% Run file for Assignment 3
global model planelist planenorm facelines
load('../../Data/data2.mat')
numberOfFrames = length(frame);

planeEq = zeros(3,4,numberOfFrames);
closestPoints = zeros(numberOfFrames,3);
bookPoints = {};
rightPlanePoints = {};
leftPlanePoints = {};
topPlanePoints = {};
originalEq = importPlanes();

fig = figure(1);
for frameNo = 1:numberOfFrames
    clf;
    hold on
    pointCloud = preProcessData(frame(frameNo));
    [planeEq(:,:,frameNo) planePoints closestPoints(frameNo,:)] = ...
        planeExtraction(pointCloud);
    bookPoints{frameNo} = bookExtraction(pointCloud,planeEq(:,:,frameNo), ...
        planePoints,closestPoints(frameNo,:));
    rightPlanePoints{frameNo} = planePoints{1};
    leftPlanePoints{frameNo} = planePoints{2};
    topPlanePoints{frameNo} = planePoints{3};
end;

transformedBookPoints = performPlaneRegistration(bookPoints,bookPoints,planeEq,originalEq(:,:,17));
transformedRightPlanePoints = performPlaneRegistration(bookPoints,rightPlanePoints,planeEq,originalEq(:,:,17));
transformedLeftPlanePoints = performPlaneRegistration(bookPoints,leftPlanePoints,planeEq,originalEq(:,:,17));
transformedTopPlanePoints = performPlaneRegistration(bookPoints,topPlanePoints,planeEq,originalEq(:,:,17));

transformedPlanePoints = {};
transformedPlanePoints{1} = transformedRightPlanePoints;
transformedPlanePoints{2} = transformedLeftPlanePoints;
transformedPlanePoints{3} = transformedTopPlanePoints;

allBookPoints = performBookFusion(transformedBookPoints);
allPlanePoints = performPlaneFusion(transformedPlanePoints);


%{
% Computing surface normal angle mean and standard deviation
[angle rotationMatrices] = findRotationMatrices(planes);
angles = [angle(1:16) angle(18:21)];
angleMean = sum(angles) / length(angles);
squaredMeanDiff = (angles-mean).^2;
stdDevAngle = sqrt(sum(squaredMeanDiff)/length(angles));
%}