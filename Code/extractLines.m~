function [frl,fcl,cr,cc] = extractLines(edges, ransacIterations, showPlots)
r = {};
c = {};
for i = 1:size(edges,2)
	[r{i},c{i}] = find(edges{i}==1);
    
    if(showPlots == true)
        figure(i);
        plot(c{i},r{i},'k.');
        axis([0 640 0 480]);
        axis ij;
        hold on;
    end;
        
	% RANSAC
	flag = 1;
	for j = 1:ransacIterations
		j
		[flag,t,d,nr,nc,count,frl,fcl,newcountl] = ransacline(r{i},c{i},1,0.1,0.01,0.001,140,3);
        plot(fcl,frl,'r.');
		hold on;
		if flag == 1 & newcountl > 0 
			[cr,cc] = plotline(t,d);
			plot(cc,cr);
            size(cc);
            size(cr);
            hold on;
		end;
	end;
	pause(0.5);
end;
  
