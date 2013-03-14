function [] = lineMatching(lineRows, lineCols)
%% perform stereo correspondance, triangulation and recognition against
%% a pre-known model

global line3d modelline line3a paircount verifycount
  
  % load stage 1 data
  res1;

  % find potential pairings
  linepairs = zeros(100,2);
  numpairs=0;
  Tep = 30;
  Tdisl = 100;
  Tdish = 250;
  Tlen = 0.22;
  Tort = 0.90;
  Tcon = 80;
  for l = 1 : llinecount
    for r = 1 : rlinecount
      if abs(llinem(l,1) - rlinem(r,1)) < Tep  ...   % epipolar
      &  abs(llinem(l,2) - rlinem(r,2)) > Tdisl ...  % min disparity
      &  abs(llinem(l,2) - rlinem(r,2)) < Tdish ...  % max disparity
      &  abs(llinel(l) - rlinel(r))     < Tlen*(llinel(l) + rlinel(r)) ...   % length
      & llinea(l,:)*rlinea(r,:)'        > Tort ...   % direction
      & abs(llineg(l) - rlineg(r))      < Tcon       % contrast
        numpairs = numpairs+1;
        linepairs(numpairs,1)=l;
        linepairs(numpairs,2)=r;
      end
    end
  end
linepairs(1:numpairs,:);

pairs = 0;      % Enforce uniqueness
pairlist = zeros(100,2);
changes = 1;
while changes
 changes = 0;
 for l = 1 : numpairs
  if linepairs(l,1) > 0
   testset = find(linepairs(:,1)==linepairs(l,1));
   if length(testset) == 1
    changes = 1;
    pairs = pairs + 1;
    pairlist(pairs,1) = linepairs(l,1);
    pairlist(pairs,2) = linepairs(l,2);
    linepairs(testset(1),:) = zeros(1,2); % clear taken
   end
  end
 end
end
pairlist(1:pairs,:)

%for l = 1 : pairs
%  [cr,cc] = plotline(llinet(pairlist(l,1)),llined(pairlist(l,1)));
%  figure(3)
%  plot(cc,cr)
%  pause(0.5)
%  [cr,cc] = plotline(rlinet(pairlist(l,2)),rlined(pairlist(l,2)));
%  figure(5)
%  plot(cc,cr)
%  pause(0.5)
%end

  % compute 3D lines thru the pairs by intersecting planes
  line3a = zeros(numpairs,3);
  line3d = zeros(numpairs,3);
  r0 = 240;
  c0 = 320;
  alpha = 832.5;
  for i = 1 : pairs
%pairlist(i,:)
    % get 2D image line equations r*ct + c*st + b = 0;
    [ctl,stl,bl] = get2Dline(llinea(pairlist(i,1),:),llinem(pairlist(i,1),:));
    [ctr,str,br] = get2Dline(rlinea(pairlist(i,2),:),rlinem(pairlist(i,2),:));
    
    % get 3D plane through each line
    nl = [alpha*stl,-alpha*ctl,r0*ctl+c0*stl+bl];
    nl = nl / norm(nl);
    cl = [0,0,0];
    dl = -nl*cl';
    nr = [alpha*str,-alpha*ctr,r0*ctr+c0*str+br];
    nr = nr / norm(nr);
%    cr = [50,0,0];
    cr = [55,0,0];
    dr = -nr*cr';

    % intersect planes to get 3D line
    [line3d(i,:),line3a(i,:)] = intersectplanes(nl,dl,nr,dr);
%i
%ld=line3d(i,:)
%la=line3a(i,:)
  end

% test angles
dots = zeros(100,3);
tmp=0;
for i = 1 : pairs-1
 for j = i+1 : pairs
   tmp = tmp+1;
   dots(tmp,:) = [i,j,acos(abs(line3d(i,:)*line3d(j,:)'))];
 end
end
dots(1:tmp,:)

line_dirs = line3d(1:pairs,:)
line_pts = line3a(1:pairs,:)
  
% pause

  % match data lines to model lines
  model;
  matchpairs = zeros(100,2);
  paircount=0;
  verifycount=0;
  success = itree(9,0,5,matchpairs,0,8);
  if success
      ['model recognised in this image']
  end
  if ~success
    ['no models recognised in this image']
  end

paircount

verifycount

