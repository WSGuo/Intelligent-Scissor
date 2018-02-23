function DMAX = calDMAX(img)
[height,width,chn] = size(img);
CMAX = -1;
%diag upper left to lower right
for x = 1:(width-1)
    for y = 1:(height-1)
        d = calD(x,y,x+1,y+1,img);
        if d > CMAX
            CMAX = d;
        end
    end
end
%diag lower left to upper right
for x = 1:(width-1)
    for y = 2:height
        d = calD(x,y,x+1,y-1,img);
        if d > CMAX
            CMAX = d;
        end
    end
end
%horizontal
for x = 1:(width-1)
    for y = 2:(height-1)
        d = calD(x, y, x+1, y,img);
        if d > CMAX
            CMAX = d;
        end
    end
end
%vertical
for x = 2:(height-1)
    for y = 2:width
        d = calD(x,y,x,y-1,img);
        if d > CMAX
            CMAX = d;
        end
    end
end
end

    

        
        
        