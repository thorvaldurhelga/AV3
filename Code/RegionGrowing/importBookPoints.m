function bookPoints = importBookPoints()
bookPoints = {}
for i=1:21
    bookPoints{i} = csvread(strcat('../../Data/bookPoints',int2str(i),'.csv'),0,0);
end;
