clear all
sampFreq = 1024;%采样数
nSamples = 2048;%采样频率
timeVec = (0:(nSamples-1))/sampFreq;%时间离散
qcCoefs=[100,0,200,pi/6,300,pi/4];
amplitude=[10,5,2.5];
sigVec =Mixedsine(timeVec,amplitude,qcCoefs);


%滤波器阶数
filtOrdr = 30;
b1 = fir1(filtOrdr,150/(sampFreq/2));%通过S1 100
b2 = fir1(filtOrdr,[190/(sampFreq/2) 210/(sampFreq/2)]);%通过S2 200
b3 = fir1(filtOrdr,250/(sampFreq/2),'high');%通过S3 300
% Apply filter
filtSig1 = fftfilt(b1,sigVec);
filtSig2 = fftfilt(b2,sigVec);
filtSig3 = fftfilt(b3,sigVec);

%% Plots
%绘制图像
subplot(4,1,1)%输出分块
plot(timeVec,sigVec)

subplot(4,1,2)%输出分块
plot(timeVec,filtSig1);

subplot(4,1,3)%输出分块
plot(timeVec,filtSig2)

subplot(4,1,4)%输出分块
plot(timeVec,filtSig3);


%周期图绘制
%Length of data |数据长度
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency|
% Nyquist frequency采样的离散傅里叶变换样本
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies|正傅里叶频率
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal|对输入信号和输出信号进行快速傅里叶变换
fftSig = fft(sigVec);
fftSig1 = fft(filtSig1);
fftSig2 = fft(filtSig2);
fftSig3 = fft(filtSig3);
% Discard negative frequencies|只保留正频率
fftSig = fftSig(1:kNyq);
fftSig1 = fftSig1(1:kNyq);
fftSig2 = fftSig2(1:kNyq);
fftSig3 = fftSig3(1:kNyq);

%Plot periodogram|绘制周期图
figure;

subplot(4,1,1)%输出分块
plot(posFreq,abs(fftSig));
axis([0 600 0 10000]);

subplot(4,1,2)%输出分块
plot(posFreq,abs(fftSig1));
axis([0 600 0 10000]);

subplot(4,1,3)%输出分块
plot(posFreq,abs(fftSig2));
axis([0 600 0 10000]);

subplot(4,1,4)%输出分块
plot(posFreq,abs(fftSig3));
axis([0 600 0 10000]);