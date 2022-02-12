function strain = strain_calc(hp,hc,theta,phi)
%输入hp  :h_+&hc  :h_x
%theta:方位角
%phi  :极角
[fp,fc] = detframefpfc(theta,phi);
strain = hp * fp + hc * fc;
end