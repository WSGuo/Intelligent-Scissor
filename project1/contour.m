%return positions (in the original image) of pixels in the contour
%input are positions in original image
function contourArray = contour(seedRow, seedCol, curRow, curCol,costGraph)
disp('start calculate contour');
nodeMat = LiveWireDPwork(-1, seedCol, seedRow, curCol, curRow, costGraph);
cur = nodeMat(curRow-1, curCol-1);
contourArray = [curRow curCol];
while isa(cur.prevNode,'Node')
    cur = cur.prevNode;
    contourArray = [contourArray;[cur.row+1 cur.col+1]];
end
%check if the end Node is the seed Node
if (cur.row+1)~= seedRow || (cur.col+1 ~= seedCol)
    disp('error: contour end is not at seed!')
end
disp('finish calculate contour')
end
    
