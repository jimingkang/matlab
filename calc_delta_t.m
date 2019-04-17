function [delta_t] = calc_delta_t(para)

% estimate the time step for numerical integration based on two criteria:
% 1.  delta_t <  1/100 * (time scales of decay for all time-dependent variables)
% 2.  delta_t < (1/4 * (smallest element size))^2/Diffusion_constant

% decay_constant = [para.K_dp, para.K_dr, para.FA_koff+para.FA_koff_R,  para.SF_koff]
delta_t_decay = 0.1*[(1./para.d_BMP)  (1./para.d_NOG)];
delta_t_decay_min  = min(delta_t_decay);

delta_t_D  =  0.1*(para.element_size/4)^2./min([para.D_BMP para.D_NOG]);   
 
delta_t = min([delta_t_decay_min delta_t_D]);




% diffusion_threshold = (para.element_size/4)^2/delta_t;




% diffusivity = [para.Dmc  para.FA_i_D];

% delta_t_D  =  (para.element_size/4)^2./diffusivity;   
% delta_t_D_min = min(delta_t_D);
% delta_t = min(delta_t_decay_min, delta_t_D_min);

% diffusion_distance_by_Le = sqrt(diffusivity*delta_t)/para.element_size

% k4 = (para.IC/(1+(para.Rho_total/para.a1)^para.n))*((1-para.f)+para.f*(0.2/para.P3b))*(1/para.Cdc_total);
% 
% delta_t_decay(4) = 0.1*(1/k4);
% 
% k5 = (para.IR+para.alpha*para.C_total).* ...
%     ((1-para.f)+para.f*(0.2/para.P3b))*  ...
%     (1/para.R_total);

% k5 = ((para.IR+para.alpha*para.Cdc_total) + para.Kon_Traction_Chemotaxis_Modified*(1/(1 + (para.Traction_mid/1)^para.Traction_n_Modified)))* ...
%      ((1-para.f) + para.f*(0.2/para.P3b))*  ...
%      (1/para.R_total)

% delta_t_decay(5) = 0.1*(1/k5);
% 
% k6 = ((para.IRho+para.beta*para.R_total)/(1+(para.C_total/para.a2)^para.n))*(1/para.Rho_total);
% delta_t_decay(6) = 0.1*(1/k6); 
% 
% k7 = para.deltaP1+(para.kPI5K/2)*(1+(para.R_total/para.Rb));
% delta_t_decay(7) = 0.1*(1/k7);
% 
% k8 = para.k21+(para.kPI3K/2)*(1+(para.R_total/para.Rb));
% delta_t_decay(8) = 0.1*(1/k8);
% 
% k9 = (para.kPTEN/2)*(1+(para.Rho_total/para.Rhob));
% delta_t_decay(9) = 0.1*(1/k9);

% delta_t_decay(10) = delta_t_D;


