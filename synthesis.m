clc;
clear;
texture = imread("braids.png");

dims =  [size(texture,1), size(texture,2)];

global patchSize;
global overlap;
global desiredDims;
global currRow;
global currCol;


%256x256 --> 1024x1024
scalingFactor = 4;
desiredDims = dims * scalingFactor;

patchSize = 48;
overlap = 32;

scaledPatchDim = desiredDims / patchSize;

tempPatch = uint8(zeros(patchSize + overlap, patchSize + overlap, 3));
finalImage = uint8(zeros(desiredDims(1), desiredDims(2), 3));


for currRow = 1:patchSize + overlap/2:desiredDims(1) 
    for currCol = 1:patchSize + overlap/2:desiredDims(2) 
        
        
        
        %%TODO Pick patch multiple times
        lowestCost = -1;
        for i = 1:20
            sampleRow = randi([1, dims(1) - (patchSize + overlap)]);
            sampleCol = randi([1, dims(2) - (patchSize + overlap)]);
            tempPatch = uint8(texture(sampleRow:(sampleRow + patchSize + overlap - 1), ...
                sampleCol:(sampleCol + patchSize + overlap - 1), :));
            [~, ~, cost] = findOverlapCost(finalImage, tempPatch);
            if cost < lowestCost || lowestCost == -1
                lowestCost = cost;
                bestPatch = tempPatch;
            end
        end
        
        
        finalImage = mergeNew(finalImage, bestPatch);
        %imshow(finalImage)
    end

end
figure(1)
imshow(finalImage);
figure(2)
imshow(texture);



%imshow(texture)