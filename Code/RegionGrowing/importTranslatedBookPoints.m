function bookPoints = importTranslatedBookPoints()
bookPoints = {}
for i=1:21
    bookPoints{i} = csvread(strcat('../../Data/translatedBookPoints',int2str(i),'.csv'),0,0);
end;
