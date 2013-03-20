function planes = importPlanes()
planes = zeros(3,4,21);
for i=1:21
    planes(:,:,i) = csvread('../../Data/planeEq.csv',(i-1)*3,0,[(i-1)*3, 0. ((i-1)*3)+2, 3]);
end;