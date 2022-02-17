%修改自text_glrtcpso.m&test_crcbqcpso.m
clear all
clc

%导入数据
load('C:\Users\MI\Desktop\GWSC\MDC\TrainingDataTF.mat')
load('C:\Users\MI\Desktop\GWSC\MDC\analysisDataTF.mat')
%基本参数
nSamples = length(dataVec);%采样点数量
timeVec = (0:(nSamples-1))/sampFreq;%离散时间序列

%通过trainData获得预估的psd
[psd,f]=pwelch(trainData,sampFreq/2,[],[],sampFreq);

%预处理
dataLen = nSamples/sampFreq;  %总数据时长
kNyq = floor(nSamples/2)+1;  %数据允许的最大频率
posFreq = (0:(kNyq-1))*(1/dataLen); %正频率

%获取posFreq相对应点上psd的值
psd = interp1(f,psd,posFreq);

%%PSO算法参数
nRuns = 8;
rmin = [40, 1, 1];
rmax = [100, 50, 15];%搜索空间

%通过pso，在指定的参数空间中搜索最小fitness（并行多次）
%给fitness function传入的参数
inParams = struct('dataX', timeVec,...
                  'dataY', dataVec,...
                  'dataXSq',timeVec.^2,...
                  'dataXCb',timeVec.^3,...
                  'rmin',rmin,...
                  'rmax',rmax,...
                  'sampFreq',sampFreq,...%采样频率
                  'psd',psd);%psd
outStruct = qcpso(inParams,struct('maxSteps',2000),nRuns);

%绘制
figure(1);
plot(timeVec,dataVec,'-');

hold on
plot(timeVec,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',0.5);
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                          '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                          '; a3=',num2str(outStruct.bestQcCoefs(3))]);%输出搜索到的a[  ]


%snr计算

nSamples = length(timeVec);
SNR=sqrt(innerprodpsd(outStruct.bestSig,outStruct.bestSig,sampFreq,psd))