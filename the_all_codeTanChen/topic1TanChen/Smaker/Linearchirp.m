function sigVec =Linearchirp(dataX,snr,qcCoefs)
% Generate a sinusoidal signal 
% S = Linearchirp(X,SNR,C)Generates a sinusoidal signal S. 
% S =Linearchirp(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1, a2, a3] that parametrize the phase of the signal:
%C是参数向量
% 2*pi*(a1*t+a2*t^2)+a3 
%函数形式
%Chen Tan, Feb 2022

phaseVec =2*pi*(qcCoefs(1)*dataX+qcCoefs(2)*dataX.^2)+qcCoefs(3);
sigVec = sin(phaseVec);%输入相位
sigVec = snr*sigVec/norm(sigVec);

