clear all
close all

load RRM.mat
data = RRM1;%time series, column vector
tol = 2; %maximum error tolerance
win = 1000;%window size
[nr,nc] = size(data);
er = inf;
for i = win+1:(nr)
    if er > tol%have we found region with low enough error?
        t= (i-win:i)';
        y = data(t);
        p = polyfit(t,y,1);%fit data with line
        y1 = polyval(p,t);%evalute fit
        er = sum((y-y1).^2)^.5;%calculate L2 error
%used to create video of finding suitable region
%        t1 = (i-win):(i+win);
%       plot(t1,data(t1), t1, polyval(p,t1));
%        title(num2str(er))
%        drawnow
    else %we found our region
        break
    end
    
end
if er > tol
    er = 'we could not meet your tolerance specifications, silly human.' %put out error
end
