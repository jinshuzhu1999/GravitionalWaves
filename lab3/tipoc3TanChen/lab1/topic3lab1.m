clear all
n = 10000;%数据数量
U = customrand(-1,1,n);%随机数据U
Y = customrandn(1,2.0,n);%随机数据Y

%直方图绘制
subplot(1,2,1)
histogram(U,'normalization','pdf')
hold on

subplot(1,2,2)
histogram(Y,'normalization','pdf')
hold on

%概率密度(PDF)图绘制
 %随机数据U
subplot(1,2,1)
x=-1:0.01:1;
pdfU=1/2*ones(1,length(x));
%U随机数据U在[-1,1]区间内均匀分布故密度分布函数取值由公式易知1/2（1-（-1））=1——>=1/2
plot(x,pdfU)
legend('samples','pdf')

  %随机数据Y
subplot(1,2,2)
x = -10:0.05:10;
pdfY=normpdf(x,2.0,1);
%随机数据Y概率密度函数满足正态分布
plot(x,pdfY)
legend('samples','pdf')
hold off
