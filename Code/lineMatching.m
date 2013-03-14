r = {}
c = {}
for i = 1:size(frame,2)
	% EDGE DETECTION
	edges = detectEdges(frame(i));
	[r{i},c{i}] = find(edges==1);
	
	plot(c{i},r{i},'k.')
	axis([0 640 0 480])
	axis ij
	hold on;
	
	% RANSAC
	flag = 1;
	for j = 1:10
		j
		[flag,t,d,nr,nc,count,frl,fcl,newcountl] = ransacline(r{i},c{i},1,0.1,0.01,0.001,140,3);
		plot(fcl,frl,'r.');
		hold on;
		if flag == 1 & newcountl > 0 
			%[cr,cc] = plotline(t,d);
			%plot(cc,cr);
			%hold on;
		end;
	end;
	
	%imshow(canny);
	pause(0.5);
end;
  
