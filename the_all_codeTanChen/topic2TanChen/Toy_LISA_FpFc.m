function [fPlus,fCross] = Toy_LISA_FpFc(polAngleTheta,polAnglePhi,t)
%给出LISA的接收函数
%波参数函数矢量
[xVec,yVec] =waveframevector(polAngleTheta,polAnglePhi);

%转化到SSB框架
nLocs = length(polAngleTheta);

nt = length(t);
xVec_t = zeros(nLocs,3,nt);
yVec_t =xVec_t;
for i = 1:nt
for lpl = 1:nLocs
    xVec_t(lpl,:,i) = VectoSSB(xVec(lpl,:),t(i));
    yVec_t(lpl,:,i) = VectoSSB(yVec(lpl,:),t(i));
end
end

%在该框架中，臂组件n1 n2 n3 
l = 2.5e9/sqrt(3);%长度
w = 2*pi/(365*24*3600); %转动圆频率

a = l * [cos(w*t)',sin(w*t)',zeros(nt,1)];
b = l * [cos(w*t + 2*pi/3)',sin(w*t + 2*pi/3)',zeros(nt,1)];
c = l * [cos(w*t + 4*pi/3)',sin(w*t + 4*pi/3)',zeros(nt,1)];
 %计算臂组件向量
n1 = b - c;
n2 = c - a;
n3 = a - b;

for i = 1:nt%每个离散时间点上
    tmp1 = VectoSSB(n1(i,:),t(i));
    tmp2 = VectoSSB(n2(i,:),t(i));
    tmp3 = VectoSSB(n3(i,:),t(i));
    %归一化
    n1(i,:) = tmp1/norm(tmp1);%归一化：矢量/模长
    n2(i,:) = tmp2/norm(tmp2);
    n3(i,:) = tmp3/norm(tmp3);
end

%Lisa 的检测器张量构建
detTensor1 = zeros(nt,3,3);
detTensor2 = detTensor1;
for i = 1:nt
    detTensor1(i,:,:) = (n1(i,:)'*n1(i,:) - n2(i,:)'*n2(i,:))/2;%由公式D1=(n1xn1-n2xn2)/2
    detTensor2(i,:,:) = (n1(i,:)'*n1(i,:) + n2(i,:)'*n2(i,:)-2 * (n3(i,:)'*n3(i,:)))/(2*sqrt(3));%由公式D1=(n1xn1+n2xn2)/2
end

fPlus = zeros(nLocs,nt,2);
fCross = zeros(nLocs,nt,2);

%对不同空间位点
%waveTensor = zeros(nt,3,3,3);
%for j =1:2
for lpl = 1:nLocs
for i =1:nt
    %张量e+
    waveTensor = xVec_t(lpl,:,i)'*xVec_t(lpl,:,i)-yVec_t(lpl,:,i)'*yVec_t(lpl,:,i);
    
    %F+=D:e+ 求和 Dij*e+ij
    detTensor = detTensor1(i,:,:);
    fPlus(lpl,i,1) = sum(waveTensor(:).*detTensor(:));
    
    detTensor = detTensor2(i,:,:);
    fPlus(lpl,i,2) = sum(waveTensor(:).*detTensor(:));

    %张量ex
    waveTensor = xVec_t(lpl,:,i)'*yVec_t(lpl,:,i)+yVec_t(lpl,:,i)'*xVec_t(lpl,:,i);
    
    %Fx=D:ex 求和 Dij*exij
    detTensor = detTensor1(i,:,:);
    fCross(lpl,i,1) = sum(waveTensor(:).*detTensor(:));

    detTensor = detTensor1(i,:,:);
    fCross(lpl,i,2) = sum(waveTensor(:).*detTensor(:));
end
%end
end
end