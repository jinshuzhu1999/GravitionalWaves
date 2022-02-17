clear all
clc
%信号输入和参数设置
load('C:\Users\MI\Desktop\GWSC\MDC\TrainingData.mat')
load('C:\Users\MI\Desktop\GWSC\MDC\analysisData.mat')%读取数据


n = length(dataVec);%采样数量
fs=sampFreq;%采样频率
data=dataVec;

%预估psd
[psd,f]=pwelch(trainData, sampFreq/2,[],[],sampFreq);%使用了默认的窗口函数获取psd
semilogy(f,psd);
%plot(f,log10(psd));
%figure(1)
%plot(f,psd);
%xlabel('Frequency (Hz)');
%ylabel('PSD');

%白化处理
b = fir2(100,f/(sampFreq/2),1./(sqrt(psd)));;%利用fir2函数设计特定白化滤波器

whitedata = fftfilt(b,dataVec);%对data进行滤波完成白化

%绘制滤出后的信号和原信号


% 光谱图绘制


% 其中因winLenSmpls要求大于ovrlpSmpls
%故要求winLen>ovrlp
a=0.8;

winLen=120;
%使用默认汉明窗口，按样本数量计算
[S,F,T]=spectrogram(data,winLen, floor(a*winLen),[],fs);%原始信号
[S1,F1,T1]=spectrogram(whitedata,winLen, floor(a*winLen),[],fs);%白化信号

  %图像输出
figure(4)
imagesc(T,F,abs(S)); 
axis xy;%限制输出为笛卡尔轴模式保证原点在左下
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('original data')
colorbar

figure(5)
imagesc(T1,F1,abs(S1));
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('whittened data')
colorbar






