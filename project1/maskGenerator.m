function mask = maskGenerator(contour,imgHeight, imgWidth)
mask = zeros(imgHeight,imgWidth,3);
numOfRow = size(contour,1);
for row  =1:numOfRow
    pos = contour(numOfRow,:);
    x = pos(1);
    y = pos(2);
    mask(y,x,1:3) = 255;
end
end
    