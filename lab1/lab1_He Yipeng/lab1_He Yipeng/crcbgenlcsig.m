function sigVec = crcbgenqcsig(dataX,snr,qcCoefs)
% Generate a linear chirp signal
% S = CRCBGENQSIG(X,SNR,C)
% Generates a sinusoidal signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% three coefficients [a1, a2, a3] that parametrize the phase of the signal:
% a1*t+a2*t^2. 

%Yipeng He, Feb 2022

phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*dataX.^2;
sigVec = sin(2*pi*phaseVec + qcCoefs(3));
sigVec = snr*sigVec/norm(sigVec);
