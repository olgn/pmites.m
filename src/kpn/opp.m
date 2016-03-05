function [h,opbias] = opp(data, knn)
%This function outputs a binary opportunity matrix, 
%which classifies whether a datapoint has opportunity
%based on the sign of the difference between the KNN (output of knn()) and 
%the data itself. 
A = data;
mu = mean(A);
h = [];
[nr,nc] = size(data);
dist=0;
%% Run through data and compare it to property value, assign opportunity
%values.
for i = 1:nr
    dist = A(i) -knn(i);
    if (dist>=0)
        h(i) = 1;
    else 
        h(i) = 0;
    end
end
%% bias the data so its easier seen on the same graph as the data/knn. 
opbias = h + mu*ones(1,nr);
opbias = opbias';
h = h';
end