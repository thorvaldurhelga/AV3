r = {}
c = {}
for i = 1:size(frame,2)
	% EDGE DETECTION
	edges = detectEdges(frame(i));
	[r{i},c{i}] = find(edges==1);
	
	plot(c{i},r{i},'k.')
	axis([0 640 0 480])
	axis ij
	pause(0.5);
	
	% RANSAC
	flag = 1;
	while flag == 1 
		[flag,t,d,nr,nc,count,frl,fcl,newcountl] = ransacline(r{i},c{i},2,0.1,0.01,0.001,80,3);
		if flag == 1 & newcountl > 0 
			[cr,cc] = plotline(t,d);
			plot(cc,cr)
		end;
	end;
	
	%imshow(canny);
	pause(0.5);
end;
  
