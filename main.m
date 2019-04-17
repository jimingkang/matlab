function main

para = parameters;

rng(1000)% set random seed for random numbers

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%                initialization                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create  initial cell
[XY,ELEMENT] = mesh_axisymmetric_circular(para.colony_diameter,para.element_size);
Nd= size(XY, 1);

% initialization to the FEM matrices, etc.
[K_diffusion_no_D,lumped_matrix,~] = solver_FEA_K_M(XY,ELEMENT);

BMP = 0.0*ones(Nd,1);
NOG = 0.0*ones(Nd,1); 
    
Traction = set_traction(XY,ELEMENT,para); % set traction stress

[delta_t] = calc_delta_t(para); para.delta_t = min([delta_t para.delta_t]);

instability_analysis(para); 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%                 time integration                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert time to time steps
para.movie_interval_n =  round(para.movie_interval/para.delta_t);
para.simulation_time_n = round(para.simulation_time/para.delta_t);

for ti= 0 : para.simulation_time_n
     
    if mod(ti,para.movie_interval_n)==0  
    %         migration_i %#ok<NOPRT>
        plot_results(para,BMP,NOG,Traction,ti,ELEMENT,XY) ; 
        pause(0.01)
    end

    % reaction diffusion simulation
    BMP_source = calc_BMP_source(para,BMP,NOG,Traction);
    [BMP]=solver_reaction_diffusion(K_diffusion_no_D,lumped_matrix, BMP,para.D_BMP,BMP_source,para.delta_t,para.rand_noise,para.max_BMP);        

    NOG_source = calc_NOG_source(para,NOG,BMP);
    [NOG]=solver_reaction_diffusion(K_diffusion_no_D,lumped_matrix, NOG,para.D_NOG,NOG_source,para.delta_t,para.rand_noise,para.max_NOG);        

end



   

