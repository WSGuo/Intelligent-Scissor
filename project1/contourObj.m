classdef contourObj
    properties
        StartX
        StartY
        EndX
        EndY
        lines
        numOfLines
        contourArray
    end
    methods
        function obj = contourObj(InputStartX,InputStartY,InputEndX,InputEndY,cGraph)
         if nargin ~= 0
            obj.StartX = InputStartX;
            obj.StartY = InputStartY;
            obj.EndX = InputEndX;
            obj.EndY = InputEndY;
            obj.contourArray = contour(InputStartX, InputStartY, InputEndX, InputEndY,cGraph);
            [n,row,col] = size(obj.contourArray);
            obj.numOfLines = n-1;
            obj.lines = line([1,2],[3,4]);
            for i = 1:(n-1)
                obj.lines(i) = line([obj.contourArray(i,1),obj.contourArray(i+1,1)],[obj.contourArray(i,2),obj.contourArray(i+1,2)],'Color','red');
            end
         end
        end
        
        function obj = delete_lines(obj)
            disp(obj.lines);
            disp('start deleting lines in obj');
            delete(obj.lines);
        end
       
        function obj = redraw_lines(obj,color)
            %delete drawn lines
            delete(obj.lines);
            for i = 1:obj.numOfLines
                obj.lines(i) = line([obj.contourArray(i,1),obj.contourArray(i+1,1)],[obj.contourArray(i,2),obj.contourArray(i+1,2)],'Color',color);
            end
        end
    end
end
