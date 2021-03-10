function [left, top, cost] = findOverlapCost(currImage, currPatch)
    global patchSize;
    global overlap;
    global currRow;
    global currCol;
    global desiredDims;
    
    left = [];
    top = [];
    cost = 0;
    %If we are doing anything but the top row
    if currRow > 1
        %Three possibilites on left, in middle, on right
        if currCol == 1
            %On left
            imageOverlap = currImage(currRow:currRow + (overlap/2) - 1, currCol:currCol + patchSize + overlap/2 - 1, :);
            patchOverlap = currPatch(1:overlap/2, (overlap/2)+1:end, :);
            l2Error = sum((imageOverlap - patchOverlap).^2, 3);
            [path, cost_t] = findShortest(l2Error');
            for i= 1:length(path)
                imageOverlap(path(i):end, i, :) = patchOverlap(path(i):end, i, :);
            end
            cost = cost + cost_t;
            top = imageOverlap;
        elseif currCol + patchSize == desiredDims(2)
            %On right
            
        else
            %On middle
            imageOverlap = currImage(currRow:currRow + (overlap/2) - 1, currCol:currCol + patchSize + overlap - 1, :);
            patchOverlap = currPatch(1:overlap/2, :, :);
            l2Error = sum((imageOverlap - patchOverlap).^2, 3);
            [path, cost_t] = findShortest(l2Error');
            for i= 1:length(path)
                imageOverlap(path(i):end, i, :) = patchOverlap(path(i):end, i, :);
            end
            cost = cost + cost_t;
            top = imageOverlap;
        end
    end
    
    %Only if we are furthest to the left is there no overlap
    if currCol > 1
       %Three possibilites top middle bot
       if currRow == 1
           %Top of image
           imageOverlap = currImage(currRow:currRow + patchSize + overlap - 1, currCol:currCol + overlap/2 - 1, :);
           patchOverlap = currPatch(1:end, 1:overlap/2, :);
           l2Error = sum((imageOverlap - patchOverlap).^2, 3);
           [path, cost_t] = findShortest(l2Error);
           for i = 1:length(path)
               imageOverlap(i, path(i):end, :) = patchOverlap(i, path(i):end, :);
           end
           cost = cost + cost_t;
           left = imageOverlap;
           
       elseif currRow + patchSize == desiredDims(1)
           %Bottom of image
       else
           %Middle of image
           imageOverlap = currImage(currRow:currRow + patchSize + overlap - 1, currCol:currCol + (overlap/2) - 1, :);
           patchOverlap = currPatch(:, 1:overlap/2, :);
           l2Error = sum((imageOverlap - patchOverlap).^2, 3);
           [path, cost_t] = findShortest(l2Error);
           for i = 1:length(path)
               imageOverlap(i, path(i):end, :) = patchOverlap(i, path(i):end, :);
           end
           cost = cost + cost_t;
           left = imageOverlap;
       end
    end
end
               