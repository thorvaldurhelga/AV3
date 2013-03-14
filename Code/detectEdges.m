function edges = detectEdges(frame)
%DETECTEDGES A pre-processing function that performs canny edge detection and removes irrelevant background information for the frame provided as input
% Input: A frame, including both image and XYZ data
% Output: Canny edges from the frame, but with irrelevant pixels in the image in each frame set to zero. A pixel is taken to be irrelevant if it is to the far left or right of the image, or if the depth of the pixel in the image is significantly greater than the depth of the object we are interested in 

	gs = rgb2gray(frame.image);
	edges = edge(gs,'canny',[0.0124,0.0624],2.5);

	% set the pixel intensities to zero for all pixels on the far left of the screen		
	edges(:,1:100) = 0;

	% set the pixel intensities to zero for all pixels on the far right of the screen	
	edges(:,580:640) = 0;

	% loop through the pixels in the XYZ image for the frame
	backgroundIndices = find(frame.XYZ(:,:,3) > 1400);
    edges(backgroundIndices) = 0;

	% return the edges for the frame
	retval = edges;

end % end of function

