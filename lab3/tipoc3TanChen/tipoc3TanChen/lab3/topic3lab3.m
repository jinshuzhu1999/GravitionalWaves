clear all
clc
iLIGO = load('C:\Users\MI\Desktop\tipoc3TanChen\lab3\iLIGOSensitivity.txt');

%plot(iLIGO(:,1)/1000,log10(iLIGO(:,2))) 
%axis([0 2 -35 -10])


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

%信号预处理（由statgaussnoisegen函数中滤波器要求）
fs=4000;%采样频率

iLIGOturn = [];%暂存矩阵
for i = 1:length(iLIGOnew(:,1))

    if (iLIGO(i,1) < fs/2 & iLIGO(i+1,1) > fs/2)
        turn1 = iLIGOnew(i+1:end,:);
        iLIGOnew(i+1,:) = [fs/2, (iLIGO(i,2) + iLIGO(i+1,2))/2];%为信号添加fs/2的频率与对应的信号强度
        iLIGOturn = iLIGOnew(1:i+1,:);
        iLIGOnew = [iLIGOnew(1:i+1,:);turn1];
        break
    end

end

iLIGOturn = [[0,iLIGOnew(1,2)];iLIGOturn];%为信号添加0的频率与对应的信号强度

iLIGO = [[0,iLIGO(1,2)];iLIGO];

%混入高斯噪音
fltrOrdr = 100;%滤波器阶数
n_sampl = 5*fs;%采样频率
outNoise = statgaussnoisegen(n_sampl,iLIGOturn,fltrOrdr,fs);

% 绘制PSD图
[pxx,f]=pwelch(outNoise, [],[],[],fs);
figure;
plot(f/1000,log10(pxx),iLIGO(:,1)/1000,log10(iLIGO(:,2)));
axis([0 2 -25 -10])
legend('noise psd','iLIGO psd')
xlabel('Frequency (Hz)');
ylabel('PSD');

% 绘制噪音图
figure;
timeVec = (0:(n_sampl-1))/fs;
plot(timeVec,outNoise);