function CMAX = calCMAX()
CMAX = -1;
%diag upper left to lower right
for x = 1:499
    for y = 1:656
        d = calD(x,y,x+1,y+1);
        if d > CMAX
            CMAX = d;
        end
    end
end
%diag lower left to upper right
for x = 1:499
    for y = 2:657
        d = calD(x,y,x+1,y-1);
        if d > CMAX
            CMAX = d;
        end
    end
end
%horizontal
for x = 1:499
    for y = 2:656
        d = calD(x, y, x+1, y);
        if d > CMAX
            CMAX = d;
        end
    end
end
%vertical
for x = 2:499
    for y = 2:657
        d = calD(x,y,x,y-1);
        if d > CMAX
            CMAX = d;
        end
    end
end
end

    

        
        
        