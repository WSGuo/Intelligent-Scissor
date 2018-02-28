function DAll = calDAll2(img)
[height,width,chn] = size(img);
DALL = zeros(height-2,width-2,3);

for i = 2:height-1
    for j = 2:width-1
        yD = calD2(i,j,img);
        % up
        DAll(3*i-5,3*j-4,1:3) = yD(3,1:3);
        % down
        DAll(3*i-3,3*j-4,1:3) = yD(7,1:3);
        % left 
        DAll(3*i-4,3*j-5,1:3) = yD(5,1:3);
        % right
        DAll(3*i-4,3*j-3,1:3) = yD(1,1:3);
        % top left
        DAll(3*i-5,3*j-5,1:3) = yD(4,1:3);
        % top right        
        DAll(3*i-5,3*j-3,1:3) = yD(2,1:3);
        % lower left
        DAll(3*i-3,3*j-5,1:3) = yD(6,1:3);
        % lower right        
        DAll(3*i-3,3*j-3,1:3) = yD(8,1:3);
    end
    
end
disp(size(DALL));

end

    

        
        
        