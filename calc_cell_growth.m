function [u_node_growth]= calc_cell_growth(Ae,EDGE_SEGMENT,edge_normal,para,XY,P)

u_node_growth = zeros(size(XY)); % dimension of all nodes
cell_area = sum(Ae);

if 1==1
    
    n_edge = length(EDGE_SEGMENT);

%     protrusion_V_coef = para.mig_prot_vel;

    P_edge = (P(EDGE_SEGMENT(:,1))+P(EDGE_SEGMENT(:,2)))/2; % average of two vertices of each edge
    
    protrusion_flag = heaviside(P_edge-para.mig_P_move);
    
%     protrusion_velocity = max((1+randn(n_edge,1))*protrusion_V_coef,0).*protrusion_flag; % protrude

    P_edge = P_edge + 1e-6; % IMPORTANT!!! TO PREVENT NUMERICAL BLOW-UP due to p_edge = 0

    protrusion_velocity = para.mig_prot_vel*exp(-(cell_area/para.cell_area_upper_limit_max)./P_edge).*protrusion_flag;
    
    u_edge_growth = protrusion_velocity*para.delta_t;

    u_growth_vector = [u_edge_growth u_edge_growth].*edge_normal;

    d_node = (u_growth_vector([n_edge 1:n_edge-1],:) + u_growth_vector(1:n_edge,:))/2;

    u_node_growth(EDGE_SEGMENT(:,1),:) = d_node; % only update the edge nodes here
    
    
end


% % % % % % % % % % % % % % if cell_area < para.cell_area_upper_limit
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     n_edge = length(EDGE_SEGMENT);
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     protrusion_V_coef = para.mig_prot_vel;
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     P_edge = (P(EDGE_SEGMENT(:,1))+P(EDGE_SEGMENT(:,2)))/2; % average of two vertices of each edge
% % % % % % % % % % % % % %     
% % % % % % % % % % % % % %     protrusion_flag = heaviside(P_edge-para.mig_P_move);
% % % % % % % % % % % % % %     
% % % % % % % % % % % % % %     protrusion_velocity = max((1+randn(n_edge,1))*protrusion_V_coef,0).*protrusion_flag; % protrude
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     u_edge_growth = protrusion_velocity*para.delta_t;
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     u_growth_vector = [u_edge_growth u_edge_growth].*edge_normal;
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     d_node = (u_growth_vector([n_edge 1:n_edge-1],:) + u_growth_vector(1:n_edge,:))/2;
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % %     u_node_growth(EDGE_SEGMENT(:,1),:) = d_node; % only update the edge nodes here
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % end
        

end