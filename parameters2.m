function para = parameters


%% FEA, time integration, mesh, remeshing related
para.initial_condition_P = 'uniform';%'random'; bell; uniform, bell
para.simulation_time = 60*6; % in seconds
para.movie_interval =  20  ; % in seconds

para.delta_t = .1; % time step

%% BMP, NOG parameters
para.rand_noise = 0.0001;

para.BMPi = 10;
para.beta_BMP = 0.001;

para.T_BMP = 0.01;

para.a_BMP =0.08;
para.b_BMP =-0.08;
para.c_BMP =0.03;
para.d_BMP =0.03;
para.D_BMP =.01;
para.max_BMP = 7.5;
para.Fmax = 0.2;


para.a_NOG =0.1;
para.b_NOG =0;
para.c_NOG =-0.15;
para.d_NOG =0.08;
para.D_NOG =0.5;
para.max_NOG = 10;


%% colony 

para.colony_diameter = 30;
para.element_size = .5;

para.rim_width = 2.4;
para.given_traction = 1;
para.thickness =          3 ;




