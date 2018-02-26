function G = costGraphToWeightGraph(costGraph)
[cHeight,cWidth,cChannel] = size(costGraph);
%construct A: square, symmetric adjacency matrix

numOfNodes = (cHeight/3) * (cWidth/3);
disp(cHeight/3);
disp(cWidth/3);
A = zeros(numOfNodes,numOfNodes);
for row = 2:3:cHeight-1
    for col = 2:3:cWidth-1
        %index of node in graph 
        index = ((row-2)/3)*(cWidth/3) + (col-2)/3 +1;
        %add wieght for link 0
        if col+1 < cWidth
            A(index,index+1) = costGraph(row,col+1,1);
            A(index+1,index) = costGraph(row,col+1,1);
        end
        %link 1
        if col+1 < cWidth && row - 1 > 1
            neighIndex = ((row-5)/3)*(cWidth/3) + (col+1)/3 +1;
            A(index,neighIndex) = costGraph(row-1,col+1,1);
            A(neighIndex,index) = costGraph(row-1,col+1,1);
        end
        %link 2
        if row-1 > 1
            neighIndex = Index - (cWidth/3);
            A(index, neighIndex) = costGraph(row-1,col,1);
            A(neighIndex,index) = costGraph(row-1,col,1);
        end
        %link 3
        if row-1 > 1 && col-1 >1
            neighIndex = ((row-5)/3)*(cWidth/3) + ((col-5)/3)+1;
            A(index, neightIndex) = costGraph(row-1,col-1,1);
            A(neighIndex, Index) = costGraph(row-1,col-1,1);
        end
    end
end
%build graph
G = graph(A);
end
