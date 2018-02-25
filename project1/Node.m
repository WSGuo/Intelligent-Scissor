classdef Node
    properties
        linkCost
        state
        totalCost
        prevNode
        col
        row
    end
    methods
        function obj = Node(F)
         if nargin ~= 0
            m = size(F,1);
            n = size(F,2);
            obj(m,n) = Node;
            for i = 1:m
               for j = 1:n
                  obj(i,j).totalCost = F(i,j);
               end
            end
         end
      end
    end
end

