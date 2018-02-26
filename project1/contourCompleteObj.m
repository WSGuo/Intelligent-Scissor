classdef contourCompleteObj
    properties
        contourObjList
        numOfcontourObj
        allpts
        its_color
    end
    methods
        function obj = contourCompleteObj()
            obj.numOfcontourObj = 0;
            obj.contourObjList = contourObj.empty();
            obj.its_color = 0;

        end
        function obj = insert(obj,inputContourObj)
            disp(obj.numOfcontourObj);
            obj.numOfcontourObj = obj.numOfcontourObj +1;
            obj.contourObjList(obj.numOfcontourObj) = inputContourObj;
            disp('inserted:');
            disp(obj.numOfcontourObj);
            disp(obj.contourObjList);
        end
        
         function obj = delete_contour(obj)
             disp('start deleting contourObj');
            for i = 1:obj.numOfcontourObj
                disp(i);
                obj.contourObjList(i) = obj.contourObjList(i).delete_lines;
            end
        end
        function obj = redraw_contour(obj,color)
            for i = 1:obj.numOfcontourObj
              obj.contourObjList(i) = redraw_lines(obj.contourObjList(i),color);
            end
        end
        function obj = delete_last(obj)
            disp(obj.numOfcontourObj);
            obj = obj.contourObjList(obj.numOfcontourObj).delete_lines;
            obj.numOfcontourObj =  obj.numOfcontourObj -1;
        end
        function result = return_region(obj)
            for i = 1:obj.numOfcontourObj
                obj.allpts = [obj.allpts;obj.contourObjList(i).contourArray];
            end
            maxX = max(obj.allpts(:,1));
            maxY = max(obj.allpts(:,2));
            minX = min(obj.allpts(:,1));
            minY = min(obj.allpts(:,2));
            result = [maxX,maxY,minX,minY];
        end

    end
end
