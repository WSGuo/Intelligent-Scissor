function LiveWireDP(seedCol,seedRow,costGraph)

%get dimension
[height,width,channel] = size(costgraph);
numOfNodes = (height/3) * (width/3);
M(1:(height/3),1:(width/3)) = Inf;

%initialize all nodes with totalCost = Inf
nodeArray = Node(M);

%initialize other properties
for row = 1:(height/3)
    for col = 1: (width/3)
        %state initial/active/expanded: 0/1/2
        nodeArray(row,col).state = 0;
        nodeArray(row,col).prevNode = [row,col];
        nodeArray(row,col).row = row;
        nodeArray(row,col).col = col;
        %pos in cost graph
        posRow = 3*(row-1) + 2;
        posCol = 3*(cal-1) + 2;
        cost0 = costGraph(posRow,posCol+1);
        cost1 = costGraph(posRow-1,posCol+1);
        cost2 = costGraph(posRow-1,posCol);
        cost3 = costGraph(posRow-1,posCol-1);
        cost4 = costGraph(posRow,posCol-1);
        cost5 = costGraph(posRow+1,posCol-1);
        cost6 = costGraph(posRow+1,posCol);
        cost7 = costGraph(posRow+1,posCol+1);
        nodeArray(linkCost) = [cost0, cost1,cost2,cost3,cost4,cost5,cost6,cost7];
    end
end

%suppose input seed is cursor position in original img
%initialize seed node
seedCol = seedCol -1;
seedRow = seedRow -1;
nodeArray(seedRow,seedCol).totalCost = 0;

%initialize empty priority queue
pq = matlab.DiscreteEventSystem.queuePriority(Node,(height/3)*(width/3),totalCost,ascending);











