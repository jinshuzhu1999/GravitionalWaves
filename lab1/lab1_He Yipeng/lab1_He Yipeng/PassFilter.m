%% Low pass filter demo
sampFreq = 1024;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq;

%% Quadratic chirp signal
% Signal parameters
a1 = 10;
a2 = 3;
a3 = 10;
A = 10;
% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
maxFreq = a1 + 2*a2*sigLen;

disp(['The maximum frequency of the linear chirp is ', num2str(maxFreq)]);

% Generate signal
sigVec = crcbgenqcsig(timeVec,A,[a1,a2,a3]);

%% Remove frequencies above half the maximum frequency
% Design pass filter
filtOrdr = 30;
b_low = fir1(filtOrdr,(maxFreq/2)/(sampFreq/2));
b_band = fir1(filtOrdr,[6/(sampFreq/2) 7/(sampFreq/2)]);
b_high = fir1(filtOrdr,10/(sampFreq/2),'high');
% Apply filter
filtSig = fftfilt(b_band,sigVec);

%% Plots
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig);