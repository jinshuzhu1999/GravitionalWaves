clear all
clc
%信号输入和参数设置
load('C:\Users\MI\Desktop\tipoc3TanChen\lab2\testData.txt');%读取数据
n = length(testData(:,1));%采样数量
t = testData(:,1);%采样时间序列
data = testData(:,2);%信号数据
fs = (n - 1)/t(end);%采样频率

%无信号部分
 %只存在于前5s,故无信号部分为
noise = data(1:floor(5*fs+1));

[psd,f]=pwelch(noise, [],[],[],fs);%使用了默认的窗口函数获取psd

figure(1)
plot(f,psd);
xlabel('Frequency (Hz)');
ylabel('PSD');



%白化处理
fltrOrdr = 500;
b = fir2(fltrOrdr,f/(fs/2),1./sqrt(psd));%利用fir2函数设计特定白化滤波器
whitedata = fftfilt(b,data);%对data进行滤波完成白化
%绘制滤出后的信号和原信号
figure(2)
plot(t,whitedata,t,data)


%周期图绘制
kNyq = floor(n/2)+1;
 % 只保留正傅里叶频率
posFreq = (0:(kNyq-1))*(1/t(end));
fft_data_tot = fft(data);%快速傅里叶变换
fft_data_tot = fft_data_tot(1:kNyq);
fft_whitedata = fft(whitedata);
fft_whitedata = fft_whitedata(1:kNyq);
%绘制滤出后的信号和原信号周期图
figure(3)
plot(posFreq,abs(fft_data_tot),posFreq,abs(fft_whitedata))


% 光谱图绘制

winLen = 0.3;%单位S
ovrlp = 0.25;%单位S  
% 其中因winLenSmpls要求大于ovrlpSmpls
%故要求winLen>ovrlp

%转化为整数样本数
winLenSmpls = floor(winLen*fs);
ovrlpSmpls = floor(ovrlp*fs);
%使用默认汉明窗口，按样本数量计算
[S,F,T]=spectrogram(data,winLenSmpls,ovrlpSmpls,[],fs);%原始信号
[S1,F1,T1]=spectrogram(whitedata,winLenSmpls,ovrlpSmpls,[],fs);%白化信号

  %图像输出
figure(4)

subplot(1,2,1)
imagesc(T,F,abs(S)); 
axis xy;%限制输出为笛卡尔轴模式保证原点在左下
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('original data')
colorbar

subplot(1,2,2)
imagesc(T1,F1,abs(S1));
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('whittened data')
colorbar






