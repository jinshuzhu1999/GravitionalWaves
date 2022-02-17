

clear all
clc
%信号输入和参数设置


load('C:\Users\MI\Desktop\GWSC\MDC\TrainingData.mat')
load('C:\Users\MI\Desktop\GWSC\MDC\analysisData.mat')

n = length(dataVec);%采样数量
t=1:length(dataVec);

%周期图绘制
kNyq = floor(n/2)+1;
 % 只保留正傅里叶频率
posFreq = (0:(kNyq-1))*(1/t(end));
fft_data_tot = fft(dataVec);%快速傅里叶变换
fft_data_tot = fft_data_tot(1:kNyq);

%绘制信号周期图
figure(1)
plot(posFreq,abs(fft_data_tot))


% 光谱图绘制
winLen = 0.3;%单位S
ovrlp = 0.25;%单位S  
% 其中因winLenSmpls要求大于ovrlpSmpls
%故要求winLen>ovrlp

%转化为整数样本数
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);
%使用默认汉明窗口，按样本数量计算
[S,F,T]=spectrogram(dataVec,winLenSmpls,ovrlpSmpls,[],sampFreq);%原始信号

  %图像输出
figure(2)
imagesc(T,F,abs(S)); 
axis xy;%限制输出为笛卡尔轴模式保证原点在左下
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('analysis Data')
colorbar






