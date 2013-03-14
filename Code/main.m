load '../Data/data1.mat'
edges = {};
lineData = {};

edges{1} = detectEdges(frame(1));
edges{2} = detectEdges(frame(2));

lineData{1} = extracLines(frame(1).image,edges,10,false);
lineData{2} = extracLines(frame(2).image,edges,10,false);

