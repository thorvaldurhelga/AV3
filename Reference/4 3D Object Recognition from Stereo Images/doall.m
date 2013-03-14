%% perform edge detection and RANSAC line fitting on left and right images

clear all
rand('state',300) 				%-- resets the state of the random number generator

% find left edges - use canny
left = imread('left.jpg','jpg');
leftr=left(:,:,1);				%-- leftr is the red channel of the left image
leftedges = edge(leftr,'canny',[0.08,0.2],3);	%-- leftedges is the set of canny edges based on the red channel of the left image
[lr,lc] = find(leftedges==1);			%-- [lr,lc] is a vector of row / column co-ordinates where there is a point on a canny edge

% plot edges from left image

figure(1)
plot(lc,lr,'k.')
title('left image edges')
axis([0 640 0 480])
axis ij
  
% right image edges - use canny
right = imread('right.jpg','jpg');		%-- rightr is the red channel of the right image
rightr=right(:,:,1);				%-- rightedges is the set of canny edges based on the red channel of the right image
rightedges = edge(rightr,'canny',[0.08,0.2],3);	%-- [rr,rc] is a vector of row / column co-ordinates where there is a point on a canny edge
[rr,rc] = find(rightedges==1);

% plot edges from right image

figure(2)
plot(rc,rr,'k.')
title('right image edges')
axis([0 640 0 480])
axis ij
  
% find left lines using ransac

figure(13)
title('left image edges found by RANSAC')
clf
%figure(3)
%clf
%plot(lc,lr,'k.')
%axis([0 640 0 480])
%axis ij
%hold on
figure(4)
clf
plot(lc,lr,'k.')
axis([0 640 0 480])
axis ij
hold on
  
  flag = 1;					%-- flag indicates that the process of overlaying lines should carry on
  sr = lr;					%-- sr = source rows, set to row values of points where there is a canny edge in left image
  sc = lc;					%-- sc = source columns, set to column values of points where there is a canny edge in left image
  llinecount = 0;				%-- llinecount = number of lines found by ransac
  llinea = zeros(100,2);			%-- llinea = ?
  llinem = zeros(100,2);			%-- llinem = ?	
  llinel = zeros(100,1);			%-- llinel = ?
  llineg = zeros(100,1);			%-- llineg = ?	
  llinet = zeros(100,1);			%-- llinet = ?
  llined = zeros(100,1);			%-- llined = ?
  while flag == 1
    [flag,t,d,nr,nc,count,frl,fcl,newcountl] = ransacline(sr,sc,2,0.1,0.01,0.001,80,3);
    if flag == 1 & newcountl > 0 
      pointsleft = size(nr);
      sr = nr;
      sc = nc;
      llinecount = llinecount+1;
      [llinea(llinecount,:),llinem(llinecount,:),llinel(llinecount), ...
            llineg(llinecount)] = descrseg(frl,fcl,leftr,4);
      llinet(llinecount) = t;
      llined(llinecount) = d;
      
       [cr,cc] = plotline(t,d);
       %figure(3)
        %plot(cc,cr)
        figure(4)
        plot(cc,cr)
        title('overlay of left image lines - from RANSAC')
        pause(0.5)    
    end
  end
  
  %% remove semi-colons on following lines to see printout of right lines

  
llinea(1:llinecount,:);
llinem(1:llinecount,:);
llinel(1:llinecount);
llineg(1:llinecount);
llinet(1:llinecount);
llined(1:llinecount);
['Left image processed - RANSAC lines found. Press return for right image']
pause
 
  % find right lines
figure(15)
title('right image edges fround by RANSAC')
clf
%figure(5)
%clf
%plot(rc,rr,'k.')
%axis([0 640 0 480])
%axis ij
%hold on
figure(6)
clf
plot(rc,rr,'k.')
title('overlay of right image lines - from RANSAC')
axis([0 640 0 480])
axis ij
hold on
    
  flag = 1;
  sr = rr;
  sc = rc;
  rlinecount = 0;
  rlinea = zeros(100,2);
  rlinem = zeros(100,2);
  rlinel = zeros(100,1);
  rlineg = zeros(100,1);
  rlinet = zeros(100,1);
  rlined = zeros(100,1);
  while flag == 1
    [flag,t,d,nr,nc,count,frr,fcr,newcountr] = ransacline(sr,sc,2,0.1,0.01,0.001,80,5);
  
    if flag == 1 & newcountr > 0 
      pointsleft = size(nr);
      sr = nr;
      sc = nc;
      rlinecount = rlinecount+1;
      [rlinea(rlinecount,:),rlinem(rlinecount,:),rlinel(rlinecount), ...
            rlineg(rlinecount)] = descrseg(frr,fcr,rightr,4);
      rlinet(rlinecount) = t;
      rlined(rlinecount) = d;
[cr,cc] = plotline(t,d);
%figure(5)
%plot(cc,cr)
figure(6)
plot(cc,cr)
pause(0.5)    
    end
  end
  
%% remove semi-colons on following lines to see printout of right lines
  
rlinea(1:rlinecount,:);
rlinem(1:rlinecount,:);
rlinel(1:rlinecount);
rlineg(1:rlinecount);
rlinet(1:rlinecount);
rlined(1:rlinecount);
['right image processed - RANSAC lines found. run stage2 to do stereo recognition']
