function [fPlus,fCross]=detframefpfc(theta,phi)
%探测器局部框架中的天线方向图功能（臂呈90度角）


%返回天线方向图函数值Fp，Fc（对应于F_+和F_x）分别表示一个给定的天空位置
% 90度等臂干涉仪。框架的X轴和Y轴指向手臂。
% T是极角（Z轴上的0弧度）和P是方位角（X轴上的0弧度）。
% T和P可以是向量（等长），在这种情况下，
% Fp和Fc也是带有Fp（i）和Fc（i）对应于T（i）和P（i）。

%Tan Chen Feb 2022

%Number of locations requested
nLocs = length(theta);

%获取指向源位置的单位向量的分量
vec2Src = [sin(theta).*cos(phi),sin(theta).*sin(phi),cos(theta)];
       
%获取波帧矢量分量
xVec = vcrossprod(repmat([0,0,1],nLocs,1),vec2Src);
yVec = vcrossprod(xVec,vec2Src);

%归一化波向量
for lpl = 1:nLocs
    xVec(lpl,:) = xVec(lpl,:)/norm(xVec(lpl,:));%计算x向量归一化

    yVec(lpl,:) = yVec(lpl,:)/norm(yVec(lpl,:));%计算y向量归一化
end


%垂直臂干涉仪的探测器张量
detTensor = ([1,0,0]'*[1,0,0]-[0,1,0]'*[0,1,0])*1/2;%垂直臂位置确定给出D=(n1xn1-n2xn2)/2

fPlus = zeros(1,nLocs);
fCross= zeros(1,nLocs);


for lpl = 1:nLocs
    %张量e+
    waveTensor=xVec(lpl,:)'*xVec(lpl,:)-yVec(lpl,:)'*yVec(lpl,:);
    %F+=D:e+ 求和 Dij*e+ij
    fPlus(lpl) = sum(waveTensor(:).*detTensor(:));%矩阵转化成列向量相乘
    %张量ex
    waveTensor = xVec(lpl,:)'*yVec(lpl,:)+yVec(lpl,:)'*xVec(lpl,:);
    %Fx=D:ex 求和 Dij*exij
    fCross(lpl) = sum(waveTensor(:).*detTensor(:));%矩阵转化成列向量相乘
end