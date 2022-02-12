function outNoise = statgaussnoisegen(nSamples,psdVals,fltrOrdr,sampFreq)
%用给定的双面PSD产生平稳高斯噪声

%Y=STATGAUSSNOISEGEN（N、PSD、O、Fs）

%生成一个目标的平稳高斯噪声的实现

%PSD给出的双面功率谱密度。Fs是采样频率

%PSD是一个M×2矩阵，包含频率和相应的

%PSD值分别位于第一列和第二列。频率

%必须从0开始，以Fs/2结束。要使用的FIR滤波器的顺序

%由O给出。





%T（f）=目标PSD平方根的FIR滤波器设计
freqVec = psdVals(:,1);
sqrtPSD = sqrt(psdVals(:,2));
b = fir2(fltrOrdr,freqVec/(sampFreq/2),sqrtPSD);




%生成一个WGN实现，并将其通过设计的过滤器

inNoise = randn(1,nSamples);
outNoise = sqrt(sampFreq)*fftfilt(b,inNoise);