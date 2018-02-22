%calculate derivative of a link
function yD = calD(x1,y1,x2,y2)
%diagonal
if abs(x1-x2) == abs(y1-y2) == 1
    yD1 = abs(img(x1,y1,1)-img(x2,y2,1))/sqrt(2);
    yD2 = abs(img(x1,y1,2)-img(x2,y2,2))/sqrt(2);
    yD3 = abs(img(x1,y1,3)-img(x2,y2,3))/sqrt(2);
elseif (x == 1 || x == 657 || y == 1 || y == 500)
    error('no link on the edge')
elseif y1 == y2   
    yD1 = abs((img(x1,y1-1,1)+img(x2,y2-1,1))/2 - (img(x1,y1+1,1)+img(x2,y2+1,1))/2);
    yD2 = abs((img(x1,y1-1,2)+img(x2,y2-1,2))/2 - (img(x1,y1+1,2)+img(x2,y2+1,2))/2);
    yD3 = abs((img(x1,y1-1,3)+img(x2,y2-1,3))/2 - (img(x1,y1+1,3)+img(x2,y2+1,3))/2);
elseif x1 == x2
    yD1 = abs((img(x1-1,y1, 1)+img(x2-1,y2,1))/2 - (img(x1+1,y1,1)+img(x2+1,y2,1))/2)
    yD2 = abs((img(x1-1,y1, 2)+img(x2-1,y2,2))/2 - (img(x1+1,y1,2)+img(x2+1,y2,2))/2)
    yD3 = abs((img(x1-1,y1, 3)+img(x2-1,y2,3))/2 - (img(x1+1,y1,3)+img(x2+1,y2,3))/2)
end
yD = sqrt((yD1*yD1 + yD2*yD2 + yD3*yD3)/3);


    

