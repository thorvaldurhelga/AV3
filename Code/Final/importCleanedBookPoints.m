function bookPoints = importCleanedBookPoints()
bookPoints = {};
for i=1:21
    bookPoints{i} = csvread(strcat('../../Data/cleanedBookPoints',int2str(i),'.csv'),0,0);
end;
