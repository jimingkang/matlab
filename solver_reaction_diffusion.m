function [nodal_variable]=solver_reaction_diffusion(FV_K_diffusion_no_D,lumped_FV_M_matrix,nodal_variable,diffusivity, ...
    source,delta_t,nodal_variable_noise,umax)

 
% note 1: sparse matrix and double for loop for matrix assembly cost
% much more time
% note 2: diffusion time scale should be larger than delta_t 
% note 3: consistent mass matrix is important for producing the correct
% result

% in this new method, the source term and diffusion term will be treated
% separately. Source term will be integrated as it is, the diffusion term will be treated by FEM.
% This way, it is not needed to convert source term at nodes to element center and then to node again in FEM

% Diffusion term is very fast, taking mean vlaue is used

%% source term contribution

d_nodal_variable_1 = delta_t*source;


% % %% Diffusition term contribution
% % if diffusivity < diffusion_threshold       
      
    % using lumped mass matrix
    d_nodal_variable_2 = - (delta_t*diffusivity)*(FV_K_diffusion_no_D*nodal_variable)./lumped_FV_M_matrix; 
    
    nodal_variable = nodal_variable + d_nodal_variable_1 + d_nodal_variable_2;

% % elseif diffusivity >= diffusion_threshold 
% %     
% %     nodal_variable = nodal_variable + d_nodal_variable_1;
% %     
% %     nodal_variable = ones(size(nodal_variable))*mean(nodal_variable); % use average value
% %     
% % end


% apply random noise

nodal_variable = nodal_variable + sqrt(nodal_variable_noise*delta_t)*randn(size(nodal_variable));



% if strcmp(flag_normalize , 'yes')
    % apply lower and upper bounds to the variable
    for j=1:length(nodal_variable)
       if nodal_variable(j) > umax
          nodal_variable(j) = umax;
       elseif nodal_variable(j) < 0
           nodal_variable(j) = 0;
       end
    end
% end


