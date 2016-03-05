
clear all
close all
load RRM.mat%load time series data converted to .mat, a (very long) column vectir
t = (1:size(RRM1,1))';
data = RRM1(1:floor(end/2));% take first half of time series
t1 = (1:size(data,1))';
p = polyfit(t1,data,1);%fit it
%plot it over half the range of the time series
y1 = polyval(p,t1);
figure
subplot(3,1,1)
plot(t1,y1,t1,data)
title('L2 Best Fit of First Half of Data')
xlabel('Time[Minutes]')
ylabel('JPY/USD')
%plot over entire series
subplot(3,1,2)
y = polyval(p,t);
plot(t,y,t,RRM1)
title('L2 Best Fit Extended to Entire Data')
xlabel('Time[Minutes]')
ylabel('JPY/USD')

subplot(3,1,3)
plot(t,abs(y-RRM1))
title('Error Between Linear Predictor and Reality')
xlabel('Time After Known Data[Minutes]')
ylabel('JPY')

%repeat
load VM.mat
t = (1:size(VM1,1))';
data = VM1(1:floor(end/2));
t1 = (1:size(data,1))';
p = polyfit(t1,data,1);
y1 = polyval(p,t1);
figure
subplot(3,1,1)
plot(t1,y1,t1,data)
title('L2 Best Fit of First Half of Data')
xlabel('Time[Minutes]')
ylabel('JPY/USD')

y = polyval(p,t);
subplot(3,1,2)
plot(t,y,t,VM1)
title('L2 Best Fit Extended to Entire Data')
xlabel('Time[Minutes]')
ylabel('JPY/USD')


subplot(3,1,3)

plot(t,abs(y-VM1))
title('Error Between Linear Predictor and Reality')
xlabel('Time After Known Data[Minutes]')
ylabel('JPY')


[x,y1,y,er] = linbs(RRM1,1,400);
