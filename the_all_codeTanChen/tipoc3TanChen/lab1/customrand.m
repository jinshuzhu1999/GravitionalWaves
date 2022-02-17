function U = customrand(a,b,n)
%生成随机数据U_ab~U（a，b）
%a,b为随机数据函数参数，n为生成数据个数
U = (b-a) * rand(1,n) + a;%随机数据满足函数

end