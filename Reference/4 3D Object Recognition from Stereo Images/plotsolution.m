% draws estimated model on top of original images
function plotsolution(Rot,trans,numpairs,pairs)

  global modelline
  global drawr drawc lastused
    
  left = imread('left.jpg','jpg');
  leftr=left(:,:,1);
  figure(1)
  clf
  colormap(gray)
  imshow(leftr)
  hold on

  right = imread('right.jpg','jpg');
  rightr=right(:,:,1);
  figure(2)
  clf
  colormap(gray)
  imshow(rightr)
  hold on

  % set up pose transform matrix
  Hproj = zeros(4,4);
  Hproj(1:3,1:3) = Rot;
  Hproj(1:3,4) = trans';
  Hproj(4,4) = 1;

  % set up left projection matrix    
  cl = [0,0,0]';
  alpha = 832.5;
  r0 = 240;
  c0 = 320;
  Kl = zeros(3,3);
  Kl(1,2) = -alpha;
  Kl(2,1) = alpha;
  Kl(1,3) = r0;  
  Kl(2,3) = c0;  
  Kl(3,3) = 1;
  Tl = zeros(3,4);
  Tl(:,1:3) = eye(3);
  Tl(:,4) = -cl;
%*** right order?  
  Pl = Kl*Tl;

  % set up right projection matrix
%  cr = [50,0,0]';
  cr = [55,0,0]';
  Kr = Kl;
  Tr = zeros(3,4);
  Tr(:,1:3) = eye(3);
  Tr(:,4) = -cr;
  Pr = Kr*Tr;

  drawr = zeros(10000,1);
  drawc = zeros(10000,1);
  [H,W] = size(leftr);
  for i = 1 : numpairs
    % left model
    pl1 = Pl*Hproj*[modelline(pairs(i,1),1:3),1]';
    pl1 = pl1/pl1(3);
    pl2 = Pl*Hproj*[modelline(pairs(i,1),4:6),1]';
    pl2 = pl2/pl2(3);
    lastused = 0;
    drawline(pl1(1:2),pl2(1:2));
    for n = 1 : lastused
      if drawr(n) > 3 & drawr(n) < H-2 & drawc(n) > 3 & drawc(n) < W-2
        for j = -3 : 3
          for k = -3 : 3
            leftr(drawr(n)+j,drawc(n)+k) = 255;
          end
        end
      end
    end
    for n = 1 : lastused
      if drawr(n) > 3 & drawr(n) < H-2 & drawc(n) > 3 & drawc(n) < W-2
        for j = -1 : 1
          for k = -1 : 1
            leftr(drawr(n)+j,drawc(n)+k) = 0;
          end
        end
      end
    end
    figure(1)
    imshow(leftr)
pause(0.5)
    
        
    % right model
    pr1 = Pr*Hproj*[modelline(pairs(i,1),1:3),1]';
    pr1 = pr1/pr1(3);
    pr2 = Pr*Hproj*[modelline(pairs(i,1),4:6),1]';
    pr2 = pr2/pr2(3);
    lastused = 0;
    drawline(pr1(1:2),pr2(1:2));
    for n = 1 : lastused
      if drawr(n) > 3 & drawr(n) < H-2 & drawc(n) > 3 & drawc(n) < W-2
        for j = -3 : 3
          for k = -3 : 3
            rightr(drawr(n)+j,drawc(n)+k) = 255;
          end
        end
      end
    end
    for n = 1 : lastused
      if drawr(n) > 3 & drawr(n) < H-2 & drawc(n) > 3 & drawc(n) < W-2
        for j = -1 : 1
          for k = -1 : 1
            rightr(drawr(n)+j,drawc(n)+k) = 0;
          end
        end
      end
    end
    figure(2)
    imshow(rightr)
pause(0.5)
  end
  
