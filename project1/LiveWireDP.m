function nodeArray = LiveWireDP(numExp, seedCol,seedRow,costGraph)

disp('start calculating LiveWireDP');
%get dimension
[height,width,channel] = size(costGraph);

%initialize all nodes with totalCost = Inf
M = zeros(height/3,width/3);
M(:) = Inf;
nodeArray = Node(M);

%initialize other properties
disp('initialize')
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
disp('finish initialize')

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

[flagEmpty] = isEmpty(pq);
%DP
%numExp= -1: no limit num of expand nodes

while ((flagEmpty == false) && (count <= numExp || numExp == -1))
    %pop top node and its totalCost value
    [costOut,nodeOut] = pop(pq);
    rowOut = nodeOut.row;
    colOut = nodeOut.col;
    nodeArray(rowOut,colOut).state = 2;
    count = count + 1;
        %for each neighbor node r of q
        row_start = rowOut-1;
        row_end = rowOut+1;
        col_start = colOut-1;
        col_end = colOut+1;
        %check boundary case
        if (row_start)<=0
            row_start = 1;
        end
        if(row_end)>height/3
            row_end = height/3;
        end
        if (col_start)<=0
            col_start = 1;
        end
        if(col_end)>width/3
            col_end = width/3;
        end
        
         
        for r = row_start:row_end
            for c = col_start:col_end
               %calculate current link cost
                    if r == rowOut-1
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(4);
                        elseif c == colOut
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(3);
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(2);
                        end   
                    elseif r == rowOut
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(5);
                        elseif c == colOut
                                continue;
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(1);
                        end
                    else 
                        % r == rowOut+1
                        if c == colOut-1
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(6);
                        elseif c == colOut
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(7);
                        else
                            linkCostCur = nodeArray(rowOut,colOut).linkCost(8);
                        end 
                    end

                if nodeArray(r,c).state == 0
                    nodeArray(r,c).prevNode = nodeArray(rowOut,colOut);
                    nodeArray(r,c).totalCost = costOut+linkCostCur;
                    nodeArray(r,c).state = 1;
                    pq.insert(nodeArray(r,c).totalCost,nodeArray(r,c));

                elseif nodeArray(r,c).state == 1
                    if costOut+linkCostCur < nodeArray(r,c).totalCost
                        nodeArray(r,c).totalCost = costOut+linkCostCur;
                        nodeArray(r,c).prevNode = nodeArray(rowOut,colOut);
                        pq.decreaseKey(r,c,costOut+linkCostCur);
                    end
                end   
            end
        end 
      [flagEmpty] = isEmpty(pq);

end
    disp('finish LiveWireDP');

end











