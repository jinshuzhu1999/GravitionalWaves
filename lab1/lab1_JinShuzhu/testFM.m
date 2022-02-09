%%plot the FM signal
% Shuzhu Jin, Lanzhou University, 2022.02.09

% Signal parameters
a1=10; %a1=qcCoefs(1)
a2=5; %a2=qcCoefs(2)
a3=3; %a3=qcCoefs(3)
A = 10;
% Instantaneous frequency after 1 sec is
% phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*cos(2*pi*qcCoefs(3)*dataX)./(2*pi)
maxFreq = a1-a2*sin(0)*2*pi*a3./(2*pi);
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Change the frequency of sampling into 5 times and 0.5 times
timeVec1 = 0:samplIntrvl/5:1.0;
timeVec2 = 0:samplIntrvl/0.5:1.0;

% Number of samples
nSamples = length(timeVec);

%Generate the signal
sigVec = FM(timeVec,A,[a1,a2,a3]);
sigVec1 = FM(timeVec1,A,[a1,a2,a3]);
sigVec2 = FM(timeVec2,A,[a1,a2,a3]);

%Plot the signal 
figure;
subplot(3,1,1)
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
subplot(3,1,2)
plot(timeVec1,sigVec1,'Marker','.','MarkerSize',24);
subplot(3,1,3)
plot(timeVec2,sigVec2,'Marker','.','MarkerSize',24);


%Plot the periodogram
%--------------
%Length of data
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency|
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));

%Plot a spectrogram
%----------------
winLen = 0.2;%sec
ovrlp = 0.15;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');