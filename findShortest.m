function [shortest] = findShortest(l2Errors)
    [rows_d, cols_d] = size(l2Errors);
    shortest = zeros(rows_d,1);
    for row = rows_d - 1:-1:1
        for col = 1:cols_d
            possibles = l2Errors(row + 1, max(1, col-1):min(col+1, cols_d));
            l2Errors(row,col) = l2Errors(row,col) + min(possibles);
        end
    end
    [~, shortest(1)] = min(l2Errors(1, :));
    for row = 2:rows_d
        [~, shortest(row)] = min(l2Errors(row, max(1, shortest(row-1)-1):min(cols_d, shortest(row-1)+1)));  
        shortest(row) = shortest(row) + max(shortest(row-1)-1, 1) - 1; 
    end