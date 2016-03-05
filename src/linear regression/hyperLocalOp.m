function [op] = hyperLocalOp(data,win)
%win: desired window size
%data: time series of exchange rates
[nr,nc] = size(data);
op = zeros(nr,nc);%set op to false originally. indicates whether it is better to have one currency or another
for i = win+1:(nr)
    t= (i-win:i)';%subset defined by window up to current time i
    y = data(t);
    p = polyfit(t,y,1); %fit said subset
    op(i) = p(1) > 0;%check the slope term of the fit for poitivity, hoping this indicates a rise
end

