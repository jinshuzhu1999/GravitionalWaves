clear all
%% 天线信号

% 信号参数
A = 10;
B = 5;
f0 = 10^-5;
phi0 = pi/3;
%探测器参数
theta = [1/6,1/5,1/4]*pi;
phi = [1/3,1/2,1/4]*pi;
psi = theta;

%确定最大频率
f_max = f0;
%确定采样频率
f_sampl = 5 * f_max;
%采样间隔
dt = 1/f_sampl;

%time vector
t = 0:dt:365*24*3600;%年
%采样数量
n_sampl = length(t);

%引力波信号生成
hp = sinmaking(t,f0,A,0);
hc = sinmaking(t,f0,B,phi0);

%fp,fc天线接收函数
fc=formulafc(phi,theta);
fp=formulafp(phi,theta);

%获得信号
for i = 1:length(fp)
    s(i,:) = hp * fp(i) + hc * fc(i);
end

%plot
subplot(6,1,1)
plot(t,s(1,:))
subplot(6,1,2)
plot(t,s(2,:))
subplot(6,1,3)
plot(t,s(3,:))
subplot(6,1,4)
plot(t,hp)
%来自天空不同位置的相同信号，接收获得信号不同
 
%% LISA response
%LISA 探测器函数 fp fc
[Fp,Fc] =Toy_LISA_FpFc(theta,phi,t);
%获得信号
strain1 = Fp(1,:,1).*hp+Fc(1,:,1).*hc;
strain2 = Fp(1,:,2).*hp+Fc(1,:,2).*hc;
strain3 = Fp(3,:,1).*hp+Fc(3,:,1).*hc;      %信号来源位置不同,接收的不同信号
n_sampl = length(t);
kNyq = floor(n_sampl/2)+1;
% 正傅里叶频率
posFreq = (0:(kNyq-1))*(1/t(end));  

fft_hp = fft(hp);
fft_hc = fft(hc);
fft_strain1 = fft(strain1);
fft_strain2 = fft(strain2);
fft_strain3 = fft(strain3);
fft_hp = fft_hp(1:kNyq);
fft_hc = fft_hc(1:kNyq);
fft_strain1 = fft_strain1(1:kNyq);
fft_strain2 = fft_strain2(1:kNyq);
fft_strain3 = fft_strain3(1:kNyq);

%绘制
subplot(6,1,5)
plot(posFreq,abs(fft_hp),posFreq,abs(fft_strain1),posFreq,abs(fft_strain2),posFreq,abs(fft_strain3))

%% 多普勒效应
R = 149597871e3; %1光年
w = 2*pi/(365*24*3600); %每年
c = 3e8; % 光速
%LISA 的质心
x_d = R*[cos(w*t)',sin(w*t)',zeros(n_sampl,1)];

%信号源方向
dir_vec = @(theta,phi) [sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta)];

hp_doppler = sinmaking(t-((dir_vec(theta(1),phi(1))*x_d')/c),f0,A,0);
hc_doppler = -sinmaking(t-((dir_vec(theta(1),phi(1))*x_d')/c),f0,A,pi/2);

%接收信号
strain1_doppler = Fp(1,:,1).*hp_doppler+Fc(1,:,1).*hc_doppler;
 
fft_hp_doppler = fft(hp_doppler);
fft_hc_doppler = fft(hc_doppler);
fft_strain1_doppler = fft(strain1_doppler);
fft_hp_doppler = fft_hp_doppler(1:kNyq);
fft_hc_doppler = fft_hc_doppler(1:kNyq);
fft_strain1_doppler = fft_strain1_doppler(1:kNyq);

subplot(6,1,6)
plot(posFreq,abs(fft_hp_doppler),posFreq,abs(fft_strain1_doppler))
xlim([5e-6,2e-5])
legend('h+','strain of det-1')
%plot(t,hp,t,hp_doppler)
%plot(((dir_vec(theta(1),phi(1))*x_d')/c))