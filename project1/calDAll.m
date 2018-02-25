function DAll = calDAll(img)
[height,width,chn] = size(img);


for i = 2:height-1
    for j = 2:width-1
        yD = calD(i,j,img);
        % up
        DAll(3*i-5,3*j-4) = yD(3);
        % down
        DAll(3*i-3,3*j-4) = yD(7);
        % left 
        DAll(3*i-4,3*j-5) = yD(5);
        % right
        DAll(3*i-4,3*j-3) = yD(1);
        % top left
        DAll(3*i-5,3*j-5) = yD(4);
        % top right        
        DAll(3*i-5,3*j-3) = yD(2);
        % lower left
        DAll(3*i-3,3*j-5) = yD(6);
        % lower right        
        DAll(3*i-3,3*j-3) = yD(8);
    end
    
end

end

    

        
        
        