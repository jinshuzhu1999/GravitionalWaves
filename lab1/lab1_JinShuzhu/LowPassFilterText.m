%% Low pass filter demo
% Shuzhu Jin, Lanzhou University, 2022.02.09
sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;
%% Quadratic chirp signal
% Signal parameters
a1=10;
a2=3;
a3=10;
A = 10;
% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
phaseVec = a1*sigLen + a2*cos(2*pi*a3*sigLen)./(2*pi);
maxFreq = a1 - a2*sin(2*pi*a3*sigLen)*a3;

disp(['The maximum frequency of the quadratic chirp is ', num2str(maxFreq)]);
%The maximum frequency of the quadratic chirp is 11.8396

% Generate signal
sigVec = FM(timeVec,A,[a1,a2,a3]);

% Design low pass filter
filtOrdr = 30;
b1 = fir1(filtOrdr,(maxFreq/2)/(sampFreq/2));
b2 = fir1(filtOrdr,50/(sampFreq/2));
b3 = fir1(filtOrdr,1/(sampFreq/2));
% Apply filter
filtSig1 = fftfilt(b1,sigVec);
filtSig2 = fftfilt(b2,sigVec);
filtSig3 = fftfilt(b3,sigVec);

%% Plots
subplot(4,1,1)
plot(timeVec,sigVec)
subplot(4,1,2)
plot(timeVec,filtSig1);
subplot(4,1,3)
plot(timeVec,filtSig2)
subplot(4,1,4)
plot(timeVec,filtSig3);