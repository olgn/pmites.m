function [prop,er,error] = knn(data,k,tol)
%This function takes an input row vector (data), and outputs 
%a "property" row vector that contains the property values for 
%the k previous neighbors. 
d = data; 
er = 0;
[nr,nc] = size(d);
s1 = nr-k+1;
s2 = nr;
error = '';
prop = [];
j = 0;
%% Run through each data point and calculate the property value of its
%k previous neighbors.
if (nr -k > 0)
    for i = 0:(nr-1)
        backend = s1-i+j;
        knn = d(backend:nr-i);
        prop(nr-i) = mean(knn);
        if (backend == 1)
            j = j+1;
        end
    end
else
    error='Please enter a k value greater than your array length';
end
%% set our outputs, compare l2norm, pop errors if applicable.
prop = prop';
er = norm(data - prop);
if er > tol
    error='Your error is greater than your tolerance.';
else
    error='All good.';
end