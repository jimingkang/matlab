function [K_diffusion_no_D,lumped_matrix,Ae]=solver_FEA_K_M(XY,ELEMENT)

 
% note 1: sparse matrix and double for loop for matrix assembly cost
% much more time
% note 2: diffusion time scale should be larger than delta_t 
% note 3: consistent mass matrix is important for producing the correct
% result


 
Nnode=size(XY,1);  
% Nnode2=Nnode*2;
Ne=size(ELEMENT,1);
    
% Assemble stiffness matrix
K_diffusion_no_D=zeros(Nnode,Nnode);
FV_M_matrix=zeros(Nnode,Nnode);
 
        
ei=ELEMENT(:,1); ej=ELEMENT(:,2); ek=ELEMENT(:,3); % element XY numbers
beta1 =XY(ej,2)-XY(ek,2);beta2 =XY(ek,2)-XY(ei,2);beta3=XY(ei,2)-XY(ej,2);
gamma1=XY(ek,1)-XY(ej,1);gamma2=XY(ei,1)-XY(ek,1);gamma3=XY(ej,1)-XY(ei,1);

beta = [beta1 beta2 beta3]; gamma = [gamma1 gamma2 gamma3];
Ae=0.5*(gamma2.*beta1-gamma1.*beta2);

%% for diffusion-reaction equations
M_over_Ae = [2 1 1;1 2 1;1 1 2]/12;

for i=1:Ne
    Kde = (1/4/Ae(i))*((beta(i,:))'*beta(i,:) + (gamma(i,:))'*gamma(i,:));

    ig_diffusion = ELEMENT(i,:);

    K_diffusion_no_D(ig_diffusion,ig_diffusion)=K_diffusion_no_D(ig_diffusion,ig_diffusion)+Kde;
    FV_M_matrix(ig_diffusion,ig_diffusion)=FV_M_matrix(ig_diffusion,ig_diffusion) + Ae(i)*M_over_Ae ;        
end   
 
% % %lumped mass matrix
lumped_matrix = sum(FV_M_matrix,2);

