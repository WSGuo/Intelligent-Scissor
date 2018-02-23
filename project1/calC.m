function yC = calC(x1,y1,x2,y2)
length = sqrt((x1-x2)* (x1 - x2)+(y1-y2)*(y1-y2));
yC = (calCMAX()-calD(x1,y1,x2,y2))*length
end
