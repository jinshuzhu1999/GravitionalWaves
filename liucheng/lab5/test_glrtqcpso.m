addpath ../../SIGNALS
addpath ../../NOISE
addpath ../../DETEST
addpath ../../SDMBIGDAT19-master/CODES   %make sure the right path 

%% define parameters 
nSamples = 512;  
sampFreq = 512; 
timeVec = (0:(nSamples-1))/sampFreq;  


%% Nuquist
dataLen = nSamples/sampFreq;   
kNyq = floor(nSamples/2)+1;   
posFreq = (0:(kNyq-1))*(1/dataLen);   


%% 
psdFunc = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625 + 1;
psdPosFreq = psdFunc(posFreq);  
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);     


snr = 10;
a1 = 3;
a2 = 2;
a3 = 5;
sigVec = crcbgenqcsig(timeVec,snr,[a1,a2,a3]);  
[sigVec,~]=normsig4psd(sigVec,sampFreq,psdPosFreq,snr);   

 
dataY = noiseVec + sigVec;


%% pso
inParams = struct( 'rmin',         [1,1,1],        ...  %三个参数a1，a2，a3的最小值组成的序列
                    'rmax',         [60,20,10],    ...
                    'dataX',        timeVec,        ...
                    'dataXSq',      timeVec.^2,     ...
                    'dataXCb',      timeVec.^3,     ...
                    'sampFreq',     sampFreq,       ...  %采样率
                    'psd',   psdPosFreq,     ...  %正频psd
                    'dataY',        dataY         ...  %模拟数据
                   );
               
%Returns all results for a total of 8 times, 
%and selects the best results for extraction
finalResult = glrtqcpso(inParams,struct('maxSteps',2000), 5);  


figure
hold on
plot(timeVec,dataY, '.','MarkerSize',12, 'Color',[78, 110, 242]/255  )
plot(timeVec,sigVec,'LineWidth',3, 'Color',[221, 80, 68]/255)
plot(timeVec,finalResult.bestSig,'LineWidth',3, 'Color',[38, 37, 36]/255)
legend('data','signal','BestSignal')
xlabel('time (s)')
hold off

disp(finalResult.bestQcCoefs)