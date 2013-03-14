function edges = detectEdges(frame)
%DETECTEDGES A pre-processing function that performs canny edge detection and removes irrelevant background information for the frame provided as input
% Input: A frame, including both image and XYZ data
% Output: Canny edges from the frame, but with irrelevant pixels in the image in each frame set to zero. A pixel is taken to be irrelevant if it is to the far left or right of the image, or if the depth of the pixel in the image is significantly greater than the depth of the object we are interested in 

	% use canny edge detection to extract the edges from the image and depth image
	red_channel = frame.image(:,:,1);%rgb2gray(frame.image);
	red_edges = edge(red_channel,'canny',[0.0124,0.0624],4);

	green_channel = frame.image(:,:,2);%rgb2gray(frame.image);
	green_edges = edge(green_channel,'canny',[0.0124,0.0624],4);

	blue_channel = frame.image(:,:,3);%rgb2gray(frame.image);
	blue_edges = edge(blue_channel,'canny',[0.0124,0.0624],4);

	% combine the canny edges from both views
	combined_edges = red_edges+green_edges+blue_edges;

	% scale the edge image so that it matches the XYZ image
	combined_edges = imcrop(combined_edges,[30 30 620 480]); %[x_left y_top x_right y_bottom]
	combined_edges = imresize(combined_edges,[480 NaN]);
	combined_edges = imcrop(combined_edges,[0 0 640 480]);

	% set the pixel intensities to zero for all pixels on the far left of the screen		
	combined_edges(:,1:100) = 0;

	% set the pixel intensities to zero for all pixels on the far right of the screen	
	combined_edges(:,590:640) = 0;

	% loop through the pixels in the XYZ image for the frame setting the combined edges value to zero if the depth is above the threshold
	backgroundIndices = find(frame.XYZ(:,:,3) > 1400);
	combined_edges(backgroundIndices) = 0;

	% return the edges for the frame
	edges = combined_edges;

end % end of function

