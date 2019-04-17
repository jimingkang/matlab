function instability_analysis(para)

A=[para.a_BMP-para.d_BMP  para.b_BMP;para.a_NOG para.b_NOG-para.d_NOG];
b=[-para.c_BMP  -para.c_NOG]';

steady_state_sol = inv(A)*b

fu = A(1,1);
gv = A(2,2);
fv = A(1,2);
gu = A(2,1);
 
d1=fu+gv;
d2=fu*gv-fv*gu;
d3=para.D_NOG*fu+para.D_BMP*gv;
d4=d3*d3-4*para.D_NOG*para.D_BMP*d2;

if d1<0 && d2>0 && d3>0 && d4>0
    disp('satisfy instable condition')
else
    disp('do not satisfy instable condition')
end

% pause