%num: number of expanded node
%row/col: row/col of seed
%cGraph: cost graph
%Show min path tree for current seed with num of expand node
function pathTreeGraph = PathTree(num,row, col, cGraph)
pathTreeGraph = cGraph;
nodeMat = LiveWireDP(num, col, row, cGraph);
disp('start calculating PathTree');
disp('input in path tree');
disp(row);
disp(col);
[nodeMatHeight,nodeMatWidth] = size(nodeMat);

%get max cost 
costMax = 0;
for r = 1:nodeMatHeight
    for c = 1: nodeMatWidth
        if nodeMat(r,c).totalCost >costMax && nodeMat(r,c).state == 2 && nodeMat(r,c).totalCost ~= Inf
            costMax = nodeMat(r,c).totalCost;
        end  
    end
end
%color links between expanded nodes to yellow
for r = 1:nodeMatHeight
    for c = 1: nodeMatWidth
        if nodeMat(r,c).state == 2 && isa(nodeMat(r,c).prevNode,'Node')
            %color the link to yellow
            rPrev = nodeMat(r,c).prevNode.row;
            cPrev = nodeMat(r,c).prevNode.col;
            %row/col InCostGraph
            rowC = 3*(r-1)+2;
            colC = 3*(c-1)+2;
            if rPrev == r - 1
                if cPrev == c + 1
                    %type = 1;
                    pathTreeGraph(rowC-1, colC+1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC-2, colC+2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                elseif cPrev == c
                    %type = 2;
                    pathTreeGraph(rowC-1, colC, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC-2, colC, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                else
                    %type = 3;
                    pathTreeGraph(rowC-1, colC-1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC-2, colC-2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                end
            elseif rPrev == r
                if cPrev == c+1
                    %type = 0;
                    pathTreeGraph(rowC, colC+1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC, colC+2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;

                else
                    %type = 4;
                    pathTreeGraph(rowC, colC-1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC, colC-2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;

                end
            else
                %rPrev == r+1
                if cPrev == c + 1
                    %type = 7;
                    pathTreeGraph(rowC+1, colC+1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC+2, colC+2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;

                elseif cPrev == c
                    %type = 6;
                    pathTreeGraph(rowC+1, colC, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC+2, colC, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;

                else
                    %type = 5;
                    pathTreeGraph(rowC+1, colC-1, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                    pathTreeGraph(rowC+2, colC-2, 1:3) = [(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,(nodeMat(r,c).totalCost/costMax)*0.5 + 0.5,0]*255;
                end
            end
        end
    end

end
disp('finish PathTree');
end


