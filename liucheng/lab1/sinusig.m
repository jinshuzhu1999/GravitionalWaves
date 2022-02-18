function sinusoidalsig = sinusig(dataX,snr,qcCoefs)

% qcCoefs(1) = f0; 
phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*dataX.^2 + qcCoefs(3)/(2 * pi);
sinusoidalsig = sin(2*pi*phaseVec);
sinusoidalsig = snr*sinusoidalsig/norm(sinusoidalsig);