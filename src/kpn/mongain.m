function [m] = mongain(data,op)
%data: time series of exchange rates, assumed for naming to be in OtherCurrency/USD minute data
%op: binary opportunity matrix, where true indicates get USD and false the opposite
[nr,nc] = size(data);
%initial available money
m = 100;
%initial curreny assumed USD(could be anything though)
usd =true;
lastOp = op(1);
for i = 1:nr
    %if opportunity matrix is unchanged then the market has not fluctuated in such a way as to make a trade necessary
    if op(i) == lastOp
        continue
    end
    lastOp = op(i);
    %when the oportunity matrix is false and we have USD then it is best to be in the non-USD currency, so we convert all of our available money using 'data'
    if op(i)==0 && usd
        m = m * data(i);
        usd = false;
    end
    %if we do not have USD and op is true we switch back to UED
    if op(i)==1 && ~usd
        m = m/ data(i);
        usd = true;
    end
end

%if not in USD, convert back
if usd==0 
    m = m/data(end);
end
%m is definitely changed, and hopefully higher, assuming op was well made
