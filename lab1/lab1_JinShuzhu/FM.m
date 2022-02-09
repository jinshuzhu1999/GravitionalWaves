function sigVec = FM(dataX,snr,qcCoefs)
% Genarate Frequency modulated (FM) sinusoid
% S = FM(X,A,f)
% Generates a quadratic chirp signal S. 
% X is the vector of time stamps at which the samples of the signal are to be computed. 
% A is the matched filtering signal-to-noise ratio of S. 
% f are the constant parameters of the signal.
% the expression of the signal: s(t)= Asin(2*pi*f0*t + b*cos(2*pi*f1*t))

% Shuzhu Jin,Lanzhou University,2022.02.09

phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*cos(2*pi*qcCoefs(3)*dataX)./(2*pi);
sigVec = sin(2*pi*phaseVec);
sigVec = snr*sigVec/norm(sigVec);


