clear all
%%绘制Linear chirp信号 

% Signal parameters|信号参数
a1=10;
a2=3;
a3=3;
A = 10;
% Instantaneous frequency after 1 sec is|1秒后瞬时频率
% phaseVec=2a1*t+a2. 相位函数
maxFreq = 2*a1;
%相位函数求导后带入t=1
% 绘制信号时间尺度在0-1s内，导函数单调，显然，1s处取得最大频率）
samplFreq = 5*maxFreq;%抽样频率 至少2倍于最大频率
samplIntrvl = 1/samplFreq;%由抽样频率

% Time samples|时间样本
timeVec = 0:samplIntrvl:1.0;
timeVec1 = 0:samplIntrvl/5:1.0;%变换抽样频率Nyquist sampling frequency*5 
timeVec2 = 0:samplIntrvl/0.5:1.0;%变换抽样频率Nyquist sampling frequency*0.5（明显失真）
% Number of samples|样本数量
nSamples = length(timeVec);

% %Generate the signal|发生信号|（发生函数可按需求更改）
sigVec = Sinusoidal(timeVec,A,[a1,a2,a3]);
sigVec1 = Sinusoidal(timeVec1,A,[a1,a2,a3]);
sigVec2 = Sinusoidal(timeVec2,A,[a1,a2,a3]);

%Plot the signal 

% |信号绘制 Nyquist sampling frequency
subplot(3,1,1)
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
%|信号绘制 Nyquist sampling frequency*5
subplot(3,1,2)
plot(timeVec1,sigVec1,'Marker','.','MarkerSize',24);
%|信号绘制 Nyquist sampling frequency*0.5
subplot(3,1,3)
plot(timeVec2,sigVec2,'Marker','.','MarkerSize',24);


%Plot the periodogram|周期图绘制

%Length of data |数据长度
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency|
% Nyquist frequency采样的离散傅里叶变换样本
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies|正傅里叶频率
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal|对信号进行快速傅里叶变换
fftSig = fft(sigVec);
% Discard negative frequencies|只保留正频率
fftSig = fftSig(1:kNyq);

%Plot periodogram|绘制周期图
figure;
plot(posFreq,abs(fftSig));

%Plot a spectrogram|光谱图
%----------------
winLen = 0.3;%单位S
ovrlp = 0.299;%单位S  
% 其中因winLenSmpls要求大于ovrlpSmpls
%故要求winLen>ovrlp

%Convert to integer number of samples |转化为整数样本个数
winLenSmpls = floor(winLen*samplFreq);%段长度指定样本数量
ovrlpSmpls = floor(ovrlp*samplFreq);%重叠采样数量
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
%使用默认汉明窗口，按样本数量计算
figure;
imagesc(T,F,abs(S));%时频图绘制
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');