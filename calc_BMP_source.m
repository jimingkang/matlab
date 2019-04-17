
function BMP_source = calc_BMP_source(para,BMP,NOG,Traction)    

% a_BMP = para.alfa*(1+para.BMPi*para.gamma_BMP);

K_ON_BMP = para.a_BMP*BMP + para.b_BMP*NOG + para.c_BMP ...
           + para.T_BMP*Traction;

Fmax = para.Fmax; %0.2;
if K_ON_BMP<0
    K_ON_BMP =0;
elseif K_ON_BMP>Fmax
    K_ON_BMP =Fmax;
end

BMP_source = K_ON_BMP - para.d_BMP * BMP + para.beta_BMP*(para.BMPi - BMP);  

end


                                
        

        
  