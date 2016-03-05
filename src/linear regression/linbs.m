function [x,y1,y,er] = linbs(data,tol)
%This function takes a data vector and an error tolerance as its inputs. 
%The output x is a linear space that spans the interval found to 
%satisfy tolerance specifications. The output y is the coefficient 
%vector, the result of matlab's polyfit command with a linear fit argument.
%y1 is the actual vector of point pairs delinearting the polynomial
%specified with coefficients, y. Er is the l2 error of our best-fit line.
%We also output a plot of data vs. best-fit line for easy inspection. 
[nr,nc] = size(data);
er = inf;
for i = 1:nr
    if er > tol
    x = linspace(0+i,nr,nr-i);
    y = data(1+i:nr,1)';
    p = polyfit(x,y,1);
    y1 = polyval(p,x);
    er = norm(y-y1);
    end
end
if er > tol
    er = 'we could not meet your tolerance specifications.';
end
figure;
hold on;
plot(x,y1,'r');
plot(x,y,'black');
hold off;
end