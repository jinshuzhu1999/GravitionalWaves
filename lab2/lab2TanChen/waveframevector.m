function [xVec,yVec] = waveframevector (polAngleTheta,polAnglePhi)
%由此函数给出波参数函数矢量
%Number of locations requested
nLocs = length(polAngleTheta);

%源位置矢量

vec2Src = [sin(polAngleTheta).*cos(polAnglePhi),sin(polAngleTheta).*sin(polAnglePhi),cos(polAngleTheta)];      
%Get the wave frame vector components (for multiple sky locations if needed)
xVec = vcrossprod(repmat([0,0,1],nLocs,1),vec2Src);
yVec = vcrossprod(xVec,vec2Src);
%Normalize wave frame vectors
for lpl = 1:nLocs
    xVec(lpl,:) = xVec(lpl,:)/norm(xVec(lpl,:));
    yVec(lpl,:) = yVec(lpl,:)/norm(yVec(lpl,:));
end
end
