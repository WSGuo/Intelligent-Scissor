function mask = maskGenerator(contour,imgHeight, imgWidth)
%initialize the mask to 
mask = zeros(imgHeight,imgWidth,3);

%color contour
numOfRow = size(contour,1);

for row =1:numOfRow
    pos = contour(row,:);
    x = pos(1);
    y = pos(2);
    %color the contour first
    mask(y, x, 1:3) = 255;
end

%color region in cotour to white 
for row = 1: imgHeight
    %flag 0 for black and 1 for white
    flag = 0;
    count = 0;
    for col = 1:imgWidth
        if mask(row,col,1) == 255
            count = count + 1;
        end
    end 
    if count > 1
        for col = 1:imgWidth
            if mask(row,col,1) == 0 && flag == 0
                continue;
            elseif mask(row,col) == 255 && flag == 0
                flag = 1;
            elseif mask(row,col,1) == 0 && flag == 1
                mask(row,col,1:3) = 255;
            elseif mask(row,col,1) == 255 && flag == 1
                flag = 0;
            end
        end
    end
end        
    
end
    