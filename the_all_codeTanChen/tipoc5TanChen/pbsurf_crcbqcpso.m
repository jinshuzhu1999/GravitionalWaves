%% Test_CRCBPSO  plot by surf
%使用功能函数CRCBPSOTESTFUNC. 

ffparams = struct('rmin',-5,'rmax',5);
% 功能函数句柄
fitFuncHandle = @(x) crcbpsotestfunc(x,ffparams);


% Call PSO.
rng('default')
psoOut = crcbpso(fitFuncHandle,2);%(功能函数句柄，函数参数个数)



%%估计参数
%找到了最好的标准化和真实坐标。 
stdCoord = psoOut.bestLocation;
[~,realCoord] = fitFuncHandle(stdCoord);

%利用surf输出
x1 = -5:0.1:5;%坐标离散化
[X1,X2] = meshgrid(x1,x1);%二维坐标网格构建
Z = zeros(size(X1));

for i = 1:length(x1)%循环结构赋值
    for j = 1:length(x1)
        Z(i,j) = fitFuncHandle([(x1(j)+5)/10,(x1(i)+5)/10]);
    end
end

surf(X1,X2,Z,'EdgeColor','none')
xlabel('x_1')
ylabel('x_2')
zlabel('f(x_1,x_2)')