
function sigVec =  FM(dataX,snr,qcCoefs)
%生成信号
% S =  FM(X,SNR,C)Generates a signal S. 
% S = FM(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1,a2,a3,a4,a5] that parametrize the phase of the signal:
%C是参数向量

%Chen Tan, Feb 2022

phaseVec1= 2*pi*qcCoefs(1)*(dataX);%相位函数
phaseVec2= 2*pi*qcCoefs(2)*(dataX-qcCoefs(3))+2*pi*qcCoefs(1)*qcCoefs(3);%相位函数
sigVec1=sin(phaseVec1);%输入相位
sigVec2=sin(phaseVec2);%输入相位
%选择输出操作
for n=1:length(dataX)
if qcCoefs(3)>=dataX(n)
    sigVec(n)= sigVec1(n);
else
   sigVec(n)=sigVec2(n);
end
end

sigVec = snr*sigVec/norm(sigVec);