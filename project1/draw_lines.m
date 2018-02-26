function lines = draw_lines(seedRow, seedCol, curRow, curCol,costGraph)
contourArray = contour(seedRow, seedCol, curRow, curCol,costGraph);

[n,row,col] = size(contourArray);
for i = 1:n-1
    lines(i) = line([contourArray(i,1),contourArray(i+1,1)],[contourArray(i,2),contourArray(i+1,2)],'Color','white');
end
end
