function nodeArray = nArrayInit(costGraph)
%get dimension
[height,width,channel] = size(costGraph);

%initialize all nodes with totalCost = Inf
M = zeros(height/3,width/3);
M(:) = Inf;
nodeArray = Node(M);

%initialize other properties
disp('initialize nArray')
for row = 1:(height/3)
    for col = 1: (width/3)
        %state initial/active/expanded: 0/1/2
        nodeArray(row,col).state = 0;
        nodeArray(row,col).prevNode = 0;
        nodeArray(row,col).row = row;
        nodeArray(row,col).col = col;
        %pos in cost graph
        posRow = 3*(row-1) + 2;
        posCol = 3*(col-1) + 2;
        cost0 = costGraph(posRow,posCol+1,1);
        cost1 = costGraph(posRow-1,posCol+1,1);
        cost2 = costGraph(posRow-1,posCol,1);
        cost3 = costGraph(posRow-1,posCol-1,1);
        cost4 = costGraph(posRow,posCol-1,1);
        cost5 = costGraph(posRow+1,posCol-1,1);
        cost6 = costGraph(posRow+1,posCol,1);
        cost7 = costGraph(posRow+1,posCol+1,1);
        nodeArray(row,col).linkCost = [cost0, cost1,cost2,cost3,cost4,cost5,cost6,cost7];
    end
end
disp('finish initialize nArray')