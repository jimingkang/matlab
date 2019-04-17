
function NOG_source = calc_NOG_source(para,NOG,BMP)

% a_NOG = para.alfa*(1+para.BMPi*para.gamma_NOG);

K_ON_NOG = para.a_NOG*BMP + para.b_NOG*NOG + para.c_NOG;

Gmax = 0.5;
if K_ON_NOG<0
    K_ON_NOG =0;
elseif K_ON_NOG>Gmax
    K_ON_NOG =Gmax;
end

NOG_source = K_ON_NOG - para.d_NOG * NOG;  

end