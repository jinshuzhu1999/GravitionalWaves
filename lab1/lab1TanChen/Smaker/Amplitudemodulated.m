
function sigVec = Amplitudemodulated(dataX,snr,qcCoefs)
%生成信号
% S = Amplitudemodulated(X,SNR,C)Generates a sinusoidal signal S. 
% S =Amplitudemodulated(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
%  SNR is the matched filtering signal-to-noise ratio of S 
%SNR是S的匹配滤波信噪比(振幅*信号范数)
% C is the vector of three coefficients [a1, a2,a3] that parametrize the phase of the signal:
%C是参数向量
% 2*pi*a1*t;
%相位函数形式1
% a2*t+a3 ;
%相位函数形式2
%Chen Tan, Feb 2022

phaseVec1 = 2*pi*qcCoefs(1)*dataX;%相位函数1
phaseVec2 =qcCoefs(2)*dataX+qcCoefs(3);%相位函数2
sigVec = cos(phaseVec1).*sin(phaseVec2);%输入相位
sigVec = snr*sigVec/norm(sigVec);