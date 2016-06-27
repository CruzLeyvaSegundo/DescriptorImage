% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo
%               
% Date:         Junho 10, 2016
%
% Syntax:       sx = heapsort(x);
%               
% Inputs:       x is a matriz of length n,m
%               
% Outputs:      sx is the sorted (ascending) version of x
%               
% Description:  This function sorts the input matriz x in ascending order
%               using the heapsort algorithm
%               
% Complexity:   O(n * log(n))    best-case performance
%               O(n * log(n))    average-case performance
%               O(n * log(n))    worst-case performance
%               O(1)             auxiliary space
%               
%--------------------------------------------------------------------------
function x = heapsort(x)
    % Build max-heap from x
    [n m]= size(x);
    x = buildmaxheap(x,n);

    % Heapsort
    heapsize = n;
    wb = waitbar(0,'Ordenando un conjunto de vectores');
    k=1;
    for i = n:-1:2
        waitbar(k/(n-1), wb);
        % Put (n + 1 - i)th largest element in place
        x = swap(x,1,i);

        % Max-heapify x(1:heapsize)
        heapsize = heapsize - 1;
        x = maxheapify(x,1,heapsize);
        k=k+1;
    end
    close(wb);
end

function x = buildmaxheap(x,n)
    % Build max-heap out of x
    % Note: In practice, x xhould be passed by reference

    for i = floor(n / 2):-1:1
        % Put children of x(i) in max-heap order
        x = maxheapify(x,i,n);
    end
end

function x = maxheapify(x,i,heapsize)
    % Put children of x(i) in max-heap order
    % Note: In practice, x xhould be passed by reference

    % Compute left/right children indices
    ll = 2 * i; % Note: In practice, use left bit shift
    rr = ll + 1; % Note: In practice, use left bit shift, then add 1 to LSB

    % Max-heapify
    if ((ll <= heapsize) && (x(ll,2) > x(i,2)))
        largest = ll;
    else
        largest = i;
    end
    if ((rr <= heapsize) && (x(rr,2) > x(largest,2)))
        largest = rr;
    end
    if (largest ~= i)
        x = swap(x,i,largest);
        x = maxheapify(x,largest,heapsize);
    end
end

function x = swap(x,i,j)
    % Swap x(i,1) and x(j.1)
    % Swap x(i,2) and x(j.2)
    % Note: In practice, x xhould be passed by reference

    val = x(i,2);
    x(i,2) = x(j,2);
    x(j,2) = val;
    val2=x(i,1);
    x(i,1) = x(j,1);
    x(j,1) = val2;
end