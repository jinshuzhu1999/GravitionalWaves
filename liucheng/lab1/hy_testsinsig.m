%% Plot the sinusoidal signal
% Signal parameters
f=10;
phi=3;
snr = 10;
% Instantaneous frequency is constant
maxFreq = f ;

% 
% %%%%%%%%%%%%%%%%%%
% % ½ of the Nyquist sampling frequency
% samplFreq = 0.5*maxFreq;
% samplIntrvl = 1/samplFreq;
% 
% % Time samples
% timeVec = 0:samplIntrvl:1.0;
% % Number of samples
% nSamples = length(timeVec);
% 
% % Generate the signal
% sigVec = one_gensinsig(timeVec,snr,[f,phi]);
% 
% %Plot the signal 
% figure;
% plot(timeVec,sigVec,'Marker','.','MarkerSize',24);


%%%%%%%%%%%%%%%%%%
%5 times the Nyquist sampling frequency
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;

% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = hy_gensinsig(timeVec,snr,[f,phi]);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);



%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
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
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');


