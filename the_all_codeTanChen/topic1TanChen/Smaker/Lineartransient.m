
function sigVec = Lineartransient(dataX,snr,qcCoefs)
%生成信号
% S = Lineartransient(X,SNR,C)Generates a chirp signal S. 
% S =Lineartransient(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1,a2,a3,a4,a5] that parametrize the phase of the signal:
%C是参数向量
% 2*pi*(a1*(t-a3)+a2*(t-a3)^2)+a4
%相位函数形式
%Chen Tan, Feb 2022

phaseVec= 2*pi*(qcCoefs(1)*(dataX-qcCoefs(3))+qcCoefs(2)*(dataX-qcCoefs(3)).^2+qcCoefs(4));%相位函数1
sigVec1=sin(phaseVec);%输入相位
%选择输出操作
for n=1:length(dataX)
if qcCoefs(3)+qcCoefs(5)>=dataX(n)&dataX(n)>=qcCoefs(3)
    sigVec(n)= sigVec1(n);
else
   sigVec(n)=0; 
end
end

sigVec = snr*sigVec/norm(sigVec);