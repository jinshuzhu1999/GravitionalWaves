
function sigVec =SineGaussian(dataX,snr,qcCoefs)
% S = SineGaussian(X,SNR,C)Generates a sinusoidal signal S. 
% S =SineGaussian(X,SNR,C)生成正弦高斯信号S
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1, a2, a3,a4,a5] that parametrize the phase of the signal:
%C是参数向量
% 2a1*t+a2. 
%相位函数形式
%Chen Tan, Feb 2022

phaseVec = 2*pi*qcCoefs(1)*dataX+qcCoefs(2) ;%相位函数
amplitude =exp(-(dataX-qcCoefs(3)).^2/(2*qcCoefs(4)));%振幅函数
sigVec = amplitude.*sin(phaseVec);%输入相位
sigVec = snr*sigVec/norm(sigVec);