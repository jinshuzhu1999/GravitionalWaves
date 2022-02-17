%% 测试 FORMULAFP ， SKYPLOT函数
%Azimuthal angle/离散方位角
phiVec = 0:0.01:(2*pi);
%Polar angle/离散极角
thetaVec = 0:0.1:pi;

%构建函数句柄 F+ and Fx from formula
fp = @(x,y) formulafp(x,y);
fc = @(x,y) formulafc(x,y);

%绘制函数图像
subplot(2,1,1)
skyplot(phiVec,thetaVec,fp);
title('F_+')
colorbar
axis equal
subplot(2,1,2)
skyplot(phiVec,thetaVec,fc);
title('F_x')
axis equal;
colorbar