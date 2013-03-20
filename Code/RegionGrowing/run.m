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
    [pointCloud planeEq planePoints closestPoints(frameNo,:)] = ...
        planeExtraction(frame(frameNo));
    bookPoints{frameNo} = bookExtraction(pointCloud,planeEq, ...
        planePoints,closestPoints(frameNo,:));
end;

