function SSB_vec = VectoSSB(det_vec,t)
%SSB框架下波参数函数矢量（坐标变换）
%旋转矩阵1:
rot_1 = [   1,  0,          0;
            0,  1/2,        sqrt(3)/2;
            0,  -sqrt(3)/2, 1/2];
    
%旋转矩阵2:
w = 2*pi/(365*24*3600);
rot_2 = [   cos(w * t),-sin(w * t),0;
            sin(w * t),cos(w * t),0
            0,              0,          1];

SSB_vec = rot_2 * rot_1 * det_vec';
SSB_vec = SSB_vec';
end