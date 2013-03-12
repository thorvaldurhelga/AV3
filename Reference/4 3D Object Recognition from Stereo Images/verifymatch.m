function success=verifymatch(Rot,trans,numpairs,pairs)

  global modelline line3d line3a verifycount

  success=0;
  threshold=20;
  verifycount = verifycount + 1;
  % see if all transformed model endpoints are close to
  % corresponding 3D data line
  for i = 1 : numpairs
    d = line3d(pairs(i,2),1:3);
    b = line3a(pairs(i,2),1:3)';
    ta1 = Rot*modelline(pairs(i,1),1:3)'+trans';
    l1 = d*(ta1-b);
    closest1 = b+l1*d';
    dist1 = norm(ta1-closest1);
    ta2 = Rot*modelline(pairs(i,1),4:6)'+trans';
    l2 = d*(ta2-b);
    closest2 = b+l2*d';
    dist2 = norm(ta2-closest2);
%[i,dist1,dist2]
    if dist1 > threshold | dist2 > threshold
      return
    end    
  end
  success=1;
  
