function [pointRows,pointCols,lineRows,lineCols] = extractLines(edges, ransacIterations, showPlots)
%DETECTEDGES A pre-processing function that performs canny edge detection and removes irrelevant background information for the frame provided as input
% INPUT: @edges - Binary image containing only edges in frame that is
%        outputted by detectEdges.m
%        @ransacIterations - Number of iterations run to fit lines to edges
%        in RANSAC 
%        @showPlots - Boolean indicating whether to plot the edges and
%        lines or not
% OUTPUT: @pointRows - Row information for the line-edge overlap points
%         @pointCols - Column information for the line-edge overlap points
%         @lineRows - Row information for the fitted line
%         @lineCols - Column information for the fitted lines

	[rows,cols] = find(edges==1);   
    if(showPlots == true)
        figure(1);
        plot(cols,rows,'k.');
        axis([0 640 0 480]);
        axis ij;
        hold on;
    end;
    
    pointRows = {};
    pointCols = {};
    lineRows = {};
    lineCols = {};
    
	% RANSAC
	for j = 1:ransacIterations
		j
		[flag,t,d,nr,nc,count,pointRows{j},pointCols{j},pointCount] = ransacline(rows,cols,1,0.1,0.01,0.001,140,3);
        if pointCount > 0
            plot(pointCols{j},pointRows{j},'r.');
            hold on;
            [lineRows{j},lineCols{j}] = plotline(t,d);
			plot(lineCols{j},lineRows{j});
            hold on;
        end;
	end;
end