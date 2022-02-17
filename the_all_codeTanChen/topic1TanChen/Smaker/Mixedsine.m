function sigVec = Mixedsine(dataX,amplitude,qcCoefs)
% Generate a sinusoidal signal 
% S = Mixedsine(X,SNR,C)Generates a sinusoidal signal S. 
% S =MixedsineG(X,SNR,C)
%  X is the vector oftime stamps at which the samples of the signal are to be computed.
%X是计算信号样本的时间戳向量
% amplitude    []   is the amplitude of different part of S 
% C is the vector of three coefficients [a1, a2, a3] that parametrize the phase of the signal:
%C是参数向量
%Chen Tan, Feb 2022

phaseVec0 = 2*pi*qcCoefs(1)*dataX + qcCoefs(2);%相位函数0
phaseVec1 = 2*pi*qcCoefs(3)*dataX + qcCoefs(4);%相位函数1
phaseVec2= 2*pi*qcCoefs(5)*dataX + qcCoefs(6);%相位函数2

sigVec0 = sin(phaseVec0);%输入相位
sigVec0 = amplitude(1)*sigVec0;

sigVec1 = sin(phaseVec1);%输入相位
sigVec1 = amplitude(2)*sigVec1;

sigVec2 =sin(phaseVec2);%输入相位
sigVec2 = amplitude(3)*sigVec2;

sigVec =sigVec0+sigVec1+sigVec2 ;

