% plot contour of field variable using nodal values using patch function

function plot_heat_map(XY_C,ELEMENT_C,z,c_map,yes_colorbar,clim_max)

element_type = size(ELEMENT_C,2);

plot_case = 'smooth_w_vertices';

switch plot_case
    
    case 'smooth_w_vertices'

        vertice_x = reshape(XY_C(reshape(ELEMENT_C,[],1),1),[],element_type);
        vertice_y = reshape(XY_C(reshape(ELEMENT_C,[],1),2),[],element_type);
        vertice_z = reshape(z(reshape(ELEMENT_C,[],1)),[],element_type);

        h = patch(vertice_x',vertice_y',vertice_z');    
                                               
        set(h,'LineStyle','none','FaceColor','interp')

    case 'element_based'
   
        h = patch('Faces',ELEMENT_C,'Vertices',XY_C,'FaceColor','flat','LineStyle','none',...
        'FaceVertexCData',z,...
        'CDataMapping','scaled');

end
% % axis equal;


colormap(c_map)

if clim_max == -1 
           
    caxis([min(0,min(z)) max(z)]);

    
elseif clim_max > 0
    
    caxis([0 clim_max]);
    
end


if strcmp(yes_colorbar, 'yes_colorbar')     
    h_bar = colorbar;
    set(h_bar,'FontSize',12,'FontWeight','bold','box','off')
end

%freezeColors  
