%calculate derivative of a link
function yD = calD2(x,y,img)
[height,width,chn] = size(img);

yD = zeros(8,3);

%link 0 
yD_0 = abs(((double(img(x-1,y,1:3)))+(double(img(x-1,y+1,1:3))))/double(2) - ((double(img(x+1,y,1:3)))+(double(img(x+1,y+1,1:3))))/double(2))/double(2);
%yD(1) = sqrt(sum(yD_0.^2)/double(3));
yD(1,1:3) = yD_0(1:3);

%link 1
yD_1 = abs(double(img(x-1,y,1:3))-double(img(x,y+1,1:3)))/double(sqrt(2));
%yD(2) = sqrt(sum(yD_1.^2)/double(3));
yD(2,1:3) = yD_1(1:3);

%link 2
yD_2 = abs(((double(img(x,y-1,1:3)))+(double(img(x-1,y-1,1:3))))/double(2) - ((double(img(x,y+1,1:3)))+(double(img(x-1,y+1,1:3))))/double(2))/double(2);
%yD(3) = sqrt(sum(yD_2.^2)/double(3));
yD(3,1:3) = yD_2(1:3);

%link 3
yD_3 = abs(double(img(x-1,y,1:3))-double(img(x,y-1,1:3)))/double(sqrt(2));
%yD(4) = sqrt(sum(yD_3.^2)/double(3));
yD(4,1:3) = yD_3(1:3);

%link 4
yD_4 = abs(((double(img(x-1,y-1,1:3)))+(double(img(x-1,y,1:3))))/double(2) - ((double(img(x+1,y-1,1:3)))+(double(img(x+1,y,1:3))))/double(2))/double(2);
%yD(5) = sqrt(sum(yD_4.^2)/double(3));
yD(5,1:3) = yD_4(1:3);

%link 5
yD_5 = abs(double(img(x,y-1,1:3))-double(img(x+1,y,1:3)))/double(sqrt(2));
%yD(6) = sqrt(sum(yD_5.^2)/double(3));
yD(6,1:3) = yD_5(1:3);

%link 6
yD_6 = abs(((double(img(x,y-1,1:3)))+(double(img(x+1,y-1,1:3))))/double(2) - ((double(img(x,y+1,1:3)))+(double(img(x+1,y+1,1:3))))/double(2))/double(2);
%yD(7) = sqrt(sum(yD_6.^2)/double(3));
yD(7,1:3) = yD_6(1:3);

%link 7 
yD_7 = abs(double(img(x,y+1,1:3))-double(img(x+1,y,1:3)))/double(sqrt(2));
%yD(8) = sqrt(sum(yD_7.^2)/double(3));
yD(8,1:3) = yD_7(1:3);

end