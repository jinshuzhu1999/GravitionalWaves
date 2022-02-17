function sigVec = crcbgenqcsig(dataX,snr,qcCoefs)
% Generate a sinusoidal signal 
% S = CRCBGENQSIG(X,SNR,C)Generates a sinusoidal signal S. 
% S =CRCBGENQSIG(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1, a2, a3] that parametrize the phase of the signal:
%C是参数向量
% a1*t+a2*t^2+a3*t^3. 
%函数形式
%Chen Tan, Feb 2022

phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*dataX.^2 + qcCoefs(3)*dataX.^3;%相位函数
sigVec = sin(2*pi*phaseVec);%输入相位
sigVec = snr*sigVec/norm(sigVec);

