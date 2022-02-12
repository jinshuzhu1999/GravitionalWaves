function [] = skyplot(phi,theta,fHandle)
%在单位球体上绘制天空角度的函数天空图（p、t、F）。

%p和t分别是方位角和极角值的矢量。F是A和D函数的函数。

%极角范围为0（z轴）到Pi（负z轴）。

%要绘制的函数名为“fp”，并接受输入“theta”和“phi”。
%>>fhandle=@（x，y）fp（x，y）

%>>天空图（0:0.1:（2*pi），0:0.1:pi，fhandle）；


%TanChen Feb 2022


%生成与方位角和极坐标对应的X、Y、Z网格

[A,D] = meshgrid(phi,theta);%二维网格构建/离散化A，D
%直角坐标对应
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);

%赋值
fVals = zeros(length(theta),length(phi));%展开二维0矩阵

for lp1 = 1:length(phi)%循环结构赋值
    for lp2 = 1:length(theta)
        fVals(lp2,lp1) = fHandle(phi(lp1),theta(lp2));%调用具体函数
    end
end

%绘制
surf(X,Y,Z,abs(fVals));
shading interp;