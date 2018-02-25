function costgraph = calC(img,costScale) % x col y row
[height,width,chn] = size(img);
cost_height = (height-2)*3;
cost_width = (width-2)*3;

DAll = calDAll(img);
DMAX = max(DAll(:));
DMAX


for i = 2:(height-1)
    for j = 2:(width-1)
        % center
        costgraph(3*i-4,3*j-4,1:3) = double(img(i,j,1:3));
      
        % up
        costgraph(3*i-5,3*j-4,1:3) = (DMAX-DAll(3*i-5,3*j-4))*1/costScale;       
        % down
        costgraph(3*i-3,3*j-4,1:3) = (DMAX-DAll(3*i-3,3*j-4))*1/costScale;
        % left 
        costgraph(3*i-4,3*j-5,1:3) = (DMAX-DAll(3*i-4,3*j-5))*1/costScale;
        % right
        costgraph(3*i-4,3*j-3,1:3) = (DMAX-DAll(3*i-4,3*j-3))*1/costScale;
        % top left
        costgraph(3*i-5,3*j-5,1:3) = (DMAX-DAll(3*i-5,3*j-5))*sqrt(2)/costScale;
        % top right        
        costgraph(3*i-5,3*j-3,1:3) = (DMAX-DAll(3*i-5,3*j-3))*sqrt(2)/costScale;
        % lower left
        costgraph(3*i-3,3*j-5,1:3) = (DMAX-DAll(3*i-3,3*j-5))*sqrt(2)/costScale;
        % lower right        
        costgraph(3*i-3,3*j-3,1:3) = (DMAX-DAll(3*i-3,3*j-3))*sqrt(2)/costScale;
    end
end


end
