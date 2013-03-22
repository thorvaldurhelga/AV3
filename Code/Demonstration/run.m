% Run file for Assignment 3
global model planelist planenorm facelines
load('../../Data/data1.mat')
planeEq = zeros(3,4,21);
closestPoints = zeros(21,3);
bookPoints = {};

fig = figure(1);
for frameNo = 1:length(frame)
    clf;
    hold on
    pointCloud = preProcessData(frame(frameNo));
    [planeEq planePoints closestPoints(frameNo,:)] = ...
        planeExtraction(pointCloud);
    bookPoints{frameNo} = bookExtraction(pointCloud,planeEq, ...
        planePoints,closestPoints(frameNo,:));
end;

% Computing surface normal angle mean and standard deviation
[angle rotationMatrices] = findRotationMatrices(planes);
angles = [angle(1:16) angle(18:21)];
angleMean = sum(angles) / length(angles);
squaredMeanDiff = (angles-mean).^2;
stdDevAngle = sqrt(sum(squaredMeanDiff)/length(angles));