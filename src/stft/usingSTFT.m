clear, clc, close all

fs =1;%sampling rate set to once per minute, assumes minute data will be used
A = load RRM.mat;
x = A(:,2);
%x = x(:, 1);                        % get the first channel
%  x = x(1:14800);
A = load('wakka2.csv');
x = A(:,2);
%filter particulars
%%filter window size
%win = 500;
%%a,b for a moving average filter
%b = zeros(1,win);
%b = (b+1)./win;
%a = 1;
%%apply either median or moving average filter
%   y = filter(b,a,x); 
%   y = medfilt1(x,win);
%   x = y;
xmax = max(abs(x));                 % find the maximum abs value
x = x/xmax;                         % scalling the signal
%% 

% define analysis parameters
xlen = length(x);                   % length of the signal
wlen = 2048;                        % window length (recomended to be power of 2)
h = wlen/4;                         % hop size (recomended to be power of 2)
nfft = 4096/2;                        % number of fft points (recomended to be power of 2)

% define the coherent amplification of the window
K = sum(hamming(wlen, 'periodic'))/wlen;

% perform STFT
[s, f, t] = stft(x, wlen, h, nfft, fs);
% take the amplitude of fft(x) and scale it, so not to be a 
% function of the length of the window and its coherent amplification
s = abs(s)/wlen/K;

%% 

% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    st(2:end, :) = s(2:end, :).*2;
else                                % even nfft includes Nyquist point
    s(2:end-1, :) = s(2:end-1, :).*2;
end

% convert amplitude spectrum to dB (min = -120 dB)
s = 20*log10(s + 1e-6);

%exlude very low frequency terms for the sake of readability
f = f(10:end);
s = s(10:end,:);

% plot the periodogram
figure(1)
I = imagesc(t, f, s);
set(gca,'YDir','normal')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, m')
ylabel('Frequency, 1/minute')
title('Amplitude spectrogram of the signal')

handl = colorbar;
set(handl, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(handl, 'Magnitude, dB')
%overlay time series data, scaled so as to appear of periodogram
hold on
plot((x-mean(x))*f(end)*20+.25,'Color','w','LineWidth',3)
hold off