function Y = customrandn(a,b,n)
%produce data N_mu_sigma ~ N(mu,sigma)
%N_mu_sigma is a  m x n matrix

Y = a* randn(1,n) + b;

end
