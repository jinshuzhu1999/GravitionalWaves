%% Topic 4Task 1
clear all
% LR的目标信噪比
snr = 10;

% Data generation parameters
nSamples = 2048;%采样数
sampFreq = 1024;%采样频率
timeVec = (0:(nSamples-1))/sampFreq;%时间离散


% 标准化信号生成
a1=10;
a2=3;
a3=3;

%sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);
sigVec = Linearchirp(timeVec,1,[a1,a2,a3]);

%使用colGaussNoiseDemo中使用的噪声PSD。但是加一个常数移除零度零件。
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;


%生成用于归一化的PSD向量。
%所有正DFT频率生成。 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%SNRcalc原代码部分
 %figure;
 %plot(posFreq,psdPosFreq);
 %axis([0,posFreq(end),0,max(psdPosFreq)]);
 %xlabel('Frequency (Hz)');
 %ylabel('PSD ((data unit)^2/Hz)');

%范数的计算
%信号平方的范数是信号与自身的内积
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
%将信号标准化为指定的信噪比
sigVec = snr*sigVec/sqrt(normSigSqrd);

%噪音发生
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
%添加标准化信号 
dataVec = noiseVec + sigVec;

%% A data realization
figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');


%周期图绘制
fft_sig = fft(sigVec);
fft_sig = fft_sig(1:kNyq);
fft_data = fft(dataVec);
fft_data = fft_data(1:kNyq);
figure;
plot(posFreq,abs(fft_data),posFreq,abs(fft_sig));
axis([0 500 0 6000])
xlabel('Frequency (Hz)');
legend('data','signal')


%光谱图绘制
winLen = 0.3;%秒
ovrlp = 0.29;%秒
%转换为整数样本
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);
[S,F,T]=spectrogram(dataVec,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar
