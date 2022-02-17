%% F_+ and F_x 用张量方法计算
%离散方位角
phi = 0:0.05:(2*pi);
%离散极角
theta = 0:0.025:pi;

%生成与方位角和极坐标对应的X、Y、Z网格

[A,D] = meshgrid(phi,theta);%二维网格构建/离散化A，D
%直角坐标对应
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);


%赋值

 %展开矩阵
fPlus = zeros(length(theta),length(phi));
fCross = zeros(length(theta),length(phi));
 %循环结构赋值
for lp1 = 1:length(phi)
    for lp2 = 1:length(theta)
        [fPlus(lp2,lp1),fCross(lp2,lp1)] = detframefpfc(theta(lp2),phi(lp1));
    end
end

%绘制

subplot(2,1,1)
surf(X,Y,Z,abs(fPlus));
title('F_+')
shading interp;
axis equal;
colorbar;

subplot(2,1,2)
surf(X,Y,Z,abs(fCross));
title('F_x')
shading interp;
axis equal;
colorbar;

