function edges = detectEdges(frame)
%DETECTEDGES A pre-processing function that performs canny edge detection and removes irrelevant background information for the frame provided as input
% Input: A frame, including both image and XYZ data
% Output: Canny edges from the frame, but with irrelevant pixels in the image in each frame set to zero. A pixel is taken to be irrelevant if it is to the far left or right of the image, or if the depth of the pixel in the image is significantly greater than the depth of the object we are interested in 

	depthimage = frame.XYZ(:,:,3).*(1/3300); % scale the depth image so that the values are roughly between zero and one

	% use canny edge detection to extract the edges from the image and depth image
	gs = rgb2gray(frame.image);
	image_edges = edge(gs,'canny',[0.0124,0.0624],4);
	di_edges = edge(depthimage,'canny',[0.0124,0.0624],4);

	% scale the edge image so that it matches the XYZ image
	image_edges = imcrop(image_edges,[38 38 600 480]); %[x_left y_top x_right y_bottom]
	image_edges = imresize(image_edges,[480 NaN]);
	image_edges = imcrop(image_edges,[0 0 640 480]);

	% combine the canny edges from both views
	combined_edges = di_edges+image_edges;

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

