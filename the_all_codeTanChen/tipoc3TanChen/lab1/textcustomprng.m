
clear all
n = 10000;%数据数量
U = customrand(-2,1,n);%随机数据U
Y = customrandn(1.5,2.0,n);%随机数据Y

%直方图绘制
subplot(1,2,1)
histogram(U,'normalization','pdf')
hold on

subplot(1,2,2)
histogram(Y,'normalization','pdf')
hold on

%概率密度图绘制
subplot(1,2,1)
plot(-2:0.1:1,1/3*ones(1,31))
legend('samples','pdf')



subplot(1,2,2)
x = -10:0.05:10;
plot(x,normpdf(x,2.0,1.5))
legend('samples','pdf')
hold off

%% Topic 3 lab2
load('C:\Users\MI\Desktop\tipoc3TanChen\lab2\testData.txt');
n_sampl = length(testData(:,1));
t = testData(:,1);
data_tot = testData(:,2);
f_sampl = (n_sampl - 1)/t(end);
%0-5s is pure noise
noise = data_tot(1:floor(5*f_sampl+1));
[psd,f]=pwelch(noise, [],[],[],f_sampl);
figure;
plot(f,psd);
xlabel('Frequency (Hz)');
ylabel('PSD');

fltrOrdr = 500;
b = fir2(fltrOrdr,f/(f_sampl/2),1./sqrt(psd));
whittened_data = fftfilt(b,data_tot);
plot(t,data_tot,t,whittened_data)

kNyq = floor(n_sampl/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/t(end));
fft_data_tot = fft(data_tot);
fft_data_tot = fft_data_tot(1:kNyq);
fft_whittened_data = fft(whittened_data);
fft_whittened_data = fft_whittened_data(1:kNyq);
plot(posFreq,abs(fft_data_tot),posFreq,abs(fft_whittened_data))
% Plot a spectrogram 
%----------------
winLen = 0.3;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*f_sampl);
ovrlpSmpls = floor(ovrlp*f_sampl);
[S,F,T]=spectrogram(data_tot,winLenSmpls,ovrlpSmpls,[],f_sampl);
[S1,F1,T1]=spectrogram(whittened_data,winLenSmpls,ovrlpSmpls,[],f_sampl);
subplot(1,2,1)
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('original data')
colorbar

subplot(1,2,2)
imagesc(T1,F1,abs(S1)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('whittened data')
colorbar