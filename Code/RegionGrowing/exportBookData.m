function exportBookData(bookData)
	fid = fopen(strcat('../../Data/bookData.csv'),'wt');
	fprintf(fid, '%d,%d,%d\n', bookData');
	fclose(fid);
