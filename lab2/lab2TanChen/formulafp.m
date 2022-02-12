function fplus = formulafp(phi,theta)

%探测器框架中90度臂干涉仪的F_+

%Fp=公式Fp（P，T）

%计算干涉仪的F_+天线方向图函数

%使用本地探测器中指定的源方向的垂直臂X轴和Y轴沿机架臂定向的机架探测器。

%T和P是包含极坐标和方位角值的标量角度，分别以弧度为单位。

%天线方向图的计算使用分析公式。
%TanChen Feb 2022


fplus = 0.5*(1+cos(theta).^2).*cos(2*phi);