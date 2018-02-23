function LiveWireDP(seedCol,seedRow,graph)
%initialize the priority queue pq to be empty

%initialize each node to the INITIAL state
[height,width,channel] = size(graph);

%construct and initialize nodes
for row = 2:(height-1)
    for cal = 2: (width-1)
        num = (row-1)*width + col;
        cost0 = calC(cal,row,col+1,row,graph);
        cost1 = calC(cal,row,cal + 1, row + 1, graph);
        cost2 = calC(cal,row, cal,row-1,graph);
        cost3 = calC(cal,row,cal-1,row-1,graph);
        cost4 = calC(cal,row,cal-1,row,graph);
        cost5 = calC(cal,row,cal-1,row+1,graph);
        cost6 = calC(cal,row,cal,row+1,graph);
        cost7 = calC(cal,row,cal+1,row+1,graph);
        node(num).linkCost = [cost0, cost1,cost2,cost3,cost4,cost5,cost6,cost7];
        node(num).state = 'INITIAL';
        node(num).totalCost = Inf;
        %prevNode added later
        node(num).col = col;
        node(num).row = row;
    end
end
seedNum = (seedRow-1)*width + seedCol;
node(seedNum).totalCost = 0;
node(seedNum).prevNode = [seedCol,seedRow];
%initialize empty priority queue
