function nodeArray = LiveWirP(numExp, seedCol,seedRow,costGraph)

%get dimension
[height,width,channel] = size(costgraph);

%initialize all nodes with totalCost = Inf
M = zeros(height/3,width/3);
M(:) = Inf;
nodeArray = Node(M);

%initialize other properties
for row = 1:(height/3)
    for col = 1: (width/3)
        %state initial/active/expanded: 0/1/2
        nodeArray(row,col).state = 0;
        nodeArray(row,col).prevNode = 0;
        nodeArray(row,col).row = row;
        nodeArray(row,col).col = col;
        %pos in cost graph
        posRow = 3*(row-1) + 2;
        posCol = 3*(cal-1) + 2;
        cost0 = costGraph(posRow,posCol+1,1);
        cost1 = costGraph(posRow-1,posCol+1,1);
        cost2 = costGraph(posRow-1,posCol,1);
        cost3 = costGraph(posRow-1,posCol-1,1);
        cost4 = costGraph(posRow,posCol-1,1);
        cost5 = costGraph(posRow+1,posCol-1,1);
        cost6 = costGraph(posRow+1,posCol,1);
        cost7 = costGraph(posRow+1,posCol+1,1);
        nodeArray(linkCost) = [cost0, cost1,cost2,cost3,cost4,cost5,cost6,cost7];
    end
end

%suppose input seed is cursor position in original img
%initialize seed node
seedCol = seedCol -1;
seedRow = seedRow -1;
nodeArray(seedRow,seedCol).totalCost = 0;

%initialize empty priority queue
pq = PriorityQueue;
pq.insert(nodeArray(seedRow,seedCol).totalCost,nodeArray(seedRow,seedCol));

%count number of expanded node
count = 0;

%DP
while pq.numElements ~= 0
    %pop top node and its totalCost value
    [costOut,nodeOut] = pq.pop();
    rowOut = nodeOut.row;
    colOut = nodeOut.col;
    nodeArray(rowOut,colOut).status = 2;
    count = count + 1;
    %numExp= -1: no limit num of expand nodes
    while (count <= numExp || numExp == -1)
        %for each neighbor node r of q  
        for r = rowOut-1:rowOut+1
            for c = colOut-1:colOut+1
               %calculate current link cost
                    if r == rowOut-1
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(3);
                        elseif c == colOut
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(2);
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(1);
                        end   
                    elseif r == rowOut
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(4);
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(0);
                        end
                    else 
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(5);
                        elseif c == colOut
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(6);
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(7);
                        end 
                    end
                if nodeArray(r,c).status == 0
                    nodeArray(r,c).prevNode = nodeArray(rowOut,colOut);
                    nodeArray(r,c).totalCost = costOut+linkCostCur;
                    nodeArray(r,c).status = 1;
                    pq.insert(nodeArray(r,c).totalCost,nodeArray(r,c));

                elseif nodeArray(r,c).status == 1
                    if costOut+linkCostCur < nodeArray(r,c).totalCost
                        nodeArray(r,c).prevNode = nodeArray(rowOut,colOut);
                        pq.decreaseKey(r,c,costOut+linkCostCur);
                    end
                end   
            end
        end
    end 
end











