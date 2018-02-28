function costgraph = calC2(img,costScale) % x col y row
[height,width,chn] = size(img);
cost_height = (height-2)*3;
cost_width = (width-2)*3;

costgraph = zeros(cost_height,cost_width,3);
DMAX_R = 0;
DMAX_G = 0;
DMAX_B = 0;

DAll = calDAll2(img);
for i = 2:(height-1)
    for j = 2:(width-1)
         if DAll(i,j,1)>DMAX_R
             DMAX_R = DAll(i,j,1);
         end
         if DAll(i,j,2)>DMAX_G
             DMAX_G = DAll(i,j,2);
         end
         if DAll(i,j,3)>DMAX_B
             DMAX_B = DAll(i,j,3);
         end
    end
end
         
DMAX_R
DMAX_G
DMAX_B

for i = 2:(height-1)
    for j = 2:(width-1)
        % center
        costgraph(3*i-4,3*j-4,1:3) = double(img(i,j,1:3));
      
        % up
        %costgraph(3*i-5,3*j-4,1:3) = (DMAX-DAll(3*i-5,3*j-4))*1/costScale; 
        costgraph(3*i-5,3*j-4,1:3) = sqrt((DMAX_R-DAll(3*i-5,3*j-4,1)).^2+(DMAX_G -DAll(3*i-5,3*j-4,2)).^2+(DMAX_B -DAll(3*i-5,3*j-4,3)).^2)*1/costScale;
        % down
        %costgraph(3*i-3,3*j-4,1:3) = (DMAX-DAll(3*i-3,3*j-4))*1/costScale;
        costgraph(3*i-3,3*j-4,1:3) = sqrt((DMAX_R-DAll(3*i-3,3*j-4,1)).^2+(DMAX_G -DAll(3*i-3,3*j-4,2)).^2+(DMAX_B -DAll(3*i-3,3*j-4,3)).^2)*1/costScale;

        % left 
        %(3*i-4,3*j-5,1:3) = (DMAX-DAll(3*i-4,3*j-5))*1/costScale;
        costgraph(3*i-4,3*j-5,1:3) = sqrt((DMAX_R-DAll(3*i-4,3*j-5,1)).^2+(DMAX_G -DAll(3*i-4,3*j-5,2)).^2+(DMAX_B -DAll(3*i-4,3*j-5,3)).^2)*1/costScale;

        % right
        %costgraph(3*i-4,3*j-3,1:3) = (DMAX-DAll(3*i-4,3*j-3))*1/costScale;
        costgraph(3*i-4,3*j-3,1:3) = sqrt((DMAX_R-DAll(3*i-4,3*j-3,1)).^2+(DMAX_G -DAll(3*i-4,3*j-3,2)).^2+(DMAX_B -DAll(3*i-4,3*j-3,3)).^2)*1/costScale;

        % top left
        %costgraph(3*i-5,3*j-5,1:3) = (DMAX-DAll(3*i-5,3*j-5))*sqrt(2)/costScale;
        costgraph(3*i-5,3*j-5,1:3) = sqrt((DMAX_R-DAll(3*i-5,3*j-5,1)).^2+(DMAX_G -DAll(3*i-5,3*j-5,2)).^2+(DMAX_B -DAll(3*i-5,3*j-5,3)).^2)*sqrt(2)/costScale;

        % top right        
        %costgraph(3*i-5,3*j-3,1:3) = (DMAX-DAll(3*i-5,3*j-3))*sqrt(2)/costScale;
         costgraph(3*i-5,3*j-3,1:3) = sqrt((DMAX_R-DAll(3*i-5,3*j-3,1)).^2+(DMAX_G -DAll(3*i-5,3*j-3,2)).^2+(DMAX_B -DAll(3*i-5,3*j-3,3)).^2)*sqrt(2)/costScale;

        % lower left
        %costgraph(3*i-3,3*j-5,1:3) = (DMAX-DAll(3*i-3,3*j-5))*sqrt(2)/costScale;
        costgraph(3*i-3,3*j-5,1:3) = sqrt((DMAX_R-DAll(3*i-3,3*j-5,1)).^2+(DMAX_G -DAll(3*i-3,3*j-5,2)).^2+(DMAX_B -DAll(3*i-3,3*j-5,3)).^2)*sqrt(2)/costScale;

        % lower right        
        %costgraph(3*i-3,3*j-3,1:3) = (DMAX-DAll(3*i-3,3*j-3))*sqrt(2)/costScale;
        costgraph(3*i-3,3*j-3,1:3) = sqrt((DMAX_R-DAll(3*i-3,3*j-3,1)).^2+(DMAX_G -DAll(3*i-3,3*j-3,2)).^2+(DMAX_B -DAll(3*i-3,3*j-3,3)).^2)*sqrt(2)/costScale;

    end
end


end
