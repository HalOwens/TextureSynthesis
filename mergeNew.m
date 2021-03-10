function finalImage = mergeNew(currImage, currPatch)
    %Im hardcoding because fuck you
    
    global patchSize;
    global overlap;
    global currRow;
    global currCol;
    
    finalImage = currImage;
    [left, top, ~] = findOverlapCost(currImage, currPatch);
    if isempty(top) && isempty(left)
        [row, col, ~] = size(currPatch);
        finalImage(1:row, 1:col, :) = currPatch;
    end
    if ~isempty(left) || ~isempty(top)
        [row, col, ~] = size(currPatch);
        currImage(currRow:row + currRow-1, currCol:col + currCol - 1, :) = currPatch;
    end
    if ~isempty(left)
        [row, col, ~] = size(left);
        currImage(currRow:row + currRow-1, currCol:col + currCol - 1, :) = left;
        
        finalImage = currImage;
    
    end
    if ~isempty(top)
        [row, col, ~] = size(top);
        currImage(currRow:row + currRow-1, currCol:col + currCol - 1, :) = top;
        
        finalImage = currImage;
    
    end

end
  
 
    