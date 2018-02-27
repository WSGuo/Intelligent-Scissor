function mask = maskGenerator(contour,imgHeight, imgWidth)
%initialize the mask to 
mask1 = zeros(imgHeight,imgWidth);

%color contour
numOfRow = size(contour,1);

xMax = 0;
yMax = 0;
xMin = imgWidth;
yMin = imgHeight;
for row =1:numOfRow
    pos = contour(row,:);
    x = pos(1);
    y = pos(2);
    if x > xMax
        xMax = x;
    end
    if y>yMax
        yMax = y;
    end
    if x<xMin
        xMin = x;
    end
    if y<yMin
        yMin = y;
    end
    %color the contour first
    mask1(y, x) = 1;
end

disp([xMin,xMax,yMin,yMax]);
mask2 = zeros(imgHeight,imgWidth);
for c = xMin:xMax
    for r = yMin:yMax
        mask2(r,c)=1;
    end
end

mask = activecontour(mask1,mask2,200);
%imshow(mask,'InitialMagnification','fit');

end
    