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




%使用iLIGO的数据(预处理)。（见topic3lab3）
iLIGO= load('C:\Users\MI\Desktop\tipoc4TanChen\iLIGOSensitivity.txt','-ascii');


%信号高频（>700Hz）低频（<700Hz）部分处理
iLIGOnew = zeros(size(iLIGO));%处理后信号储存矩阵
for i = 1:length(iLIGO(:,1))
     iLIGOnew(1:i,1) = iLIGO(1:i,1);
    if (iLIGO(i,1) < 50 & iLIGO(i+1,1) > 50)%判断频率刚好低于50Hz
        iLIGOnew(1:i,1) = iLIGO(1:i,1);
        iLIGOnew(1:i,2) = iLIGO(i,2)*ones(i,1);%令低频部分均等于频率对应信号强度
   
    elseif (iLIGO(i,1) < 700 & iLIGO(i+1,1) > 700)%判断频率刚好大于700Hz
        iLIGOnew(i:end,1) = iLIGO(i:end,1);
        iLIGOnew(i:end,2) = iLIGO(i,2)*ones(length(iLIGO)- i+1,1);%令高频部分均等于频率对应信号强度
        break
    else
        iLIGOnew(i,2) = iLIGO(i,2);%中间频率部分不做变动
    end
end

%生成用于归一化的PSD向量。
%所有正DFT频率生成。 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

psdPosFreq = interp1(iLIGOnew(:,1),iLIGOnew(:,2),posFreq);
psdPosFreq(1) = psdPosFreq(3);
psdPosFreq(2) = psdPosFreq(3);
figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);
xlabel('Frequency (Hz)');
ylabel('PSD ((data unit)^2/Hz)');

%范数的计算
%信号平方的范数是信号与自身的内积
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
%将信号标准化为指定的信噪比
sigVec = snr*sigVec/sqrt(normSigSqrd);


%%测试(搬运自SNRcalc)
%获取多个噪声实现的LLR值
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdPosFreq);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);

for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    % Add normalized signal
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);

%%
% 绘制噪音
figure;
plot(timeVec,noiseVec);
xlabel('Time (sec)');
ylabel('Noise');
%%
% 绘制数据
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
