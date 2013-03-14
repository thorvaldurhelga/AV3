function retval = removeBackground(frameArray)
%REMOVEBACKGROUND A pre-processing function that removes irrelevant background information from each frame in the frame array provided as input
% Input: An array of frames representing the the data, with each frame including both image and XYZ data
% Output: The same frame array, but with irrelevant pixels in the image in each frame set to zero. A pixel is taken to be irrelevant if it is to the far left or right of the image, or if the depth of the pixel is significantly greater than the depth of the object we are interested in 

	edges = {};

	% loop through the frames in the array
	for i = 1 : length(frameArray)

		gs = rgb2gray(frameArray(i).image);
		edgesForFrame = edge(gs,'canny',[0.0124,0.0624],2.5);

		% for each frame set the pixel intensities to zero for all pixels on the far left of the screen		
%		frameArray(i).image(:,1:100,:) = 0;
		edgesForFrame(:,1:100) = 0;

		% for each frame set the pixel intensities to zero for all pixels on the far right of the screen	
%		frameArray(i).image(:,580:640,:) = 0;
		edgesForFrame(:,580:640) = 0;

		% loop through the pixels in the XYZ image for the frame
        backgroundIndices = find(frameArray(i).XYZ(:,:,3) > 1400);
        edgesForFrame(backgroundIndices) = 0;


	edges{i} = edgesForFrame;

	end % end of for loop

	% return the frame array
	retval = edges;

end % end of function

