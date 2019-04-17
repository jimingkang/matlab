% genreate triangular mesh for a circular cell

function [XY,ELEMENT] = mesh_axisymmetric_circular(colony_diameter,element_size)

Rc = colony_diameter/2;

layer_n = round(Rc/element_size);

i=1; % start with the inner circular lines, from center to edge
ri = Rc/layer_n*i;
c = 2*pi*ri;
pn = round(c/element_size);
theta = (linspace(0,2*pi,pn+1))';  
theta = theta(1:pn)+pi/pn*mod(i,2);
xy = [ri*cos(theta)  ri*sin(theta)];


for i=2:layer_n - 2
    ri = Rc/layer_n*i;
    c = 2*pi*ri;
    pn = round(c/element_size);
    theta = (linspace(0,2*pi,pn+1))';  
    theta = theta(1:pn)+pi/pn*mod(i,2);
    xy = [xy; [ri*cos(theta)  ri*sin(theta)]];
end

% for the outmost two circumfential loops, equal number of
% points are assgned, with phase shift
i=layer_n - 1;
ri = Rc/layer_n*i;
% c = 2*pi*ri;
pn = round(2*pi*Rc/element_size);  % use Rc, instead of ri
theta = (linspace(0,2*pi,pn+1))';  
theta = theta(1:pn)+pi/pn*mod(i,2);
xy = [xy; [ri*cos(theta)  ri*sin(theta)]];  

i=layer_n  ;
ri = Rc;
c = 2*pi*ri;
pn = round(c/element_size);
theta = (linspace(0,2*pi,pn+1))';  
theta = theta(1:pn)+pi/pn*mod(i,2);
xy = [xy; [ri*cos(theta)  ri*sin(theta)]];                

% finally, add the center ponit
xy = [xy;[0 0]];

XY = xy;

ELEMENT = delaunay(xy(:,1),xy(:,2));

% ELEMENT_CENTER=(XY(ELEMENT(:,1),:)+ XY(ELEMENT(:,2),:)+XY(ELEMENT(:,3),:))/3; % element center
  
Ne= size(ELEMENT, 1);   
Nd= size(XY, 1);  

%% make sure the node numbering is counter-clockwise order
% Triangle area
Ae = f_tri_area(XY,ELEMENT);
for i=1:Ne
    if Ae(i)<0.0
        % Flip node numbering to give a counter-clockwise order
        disp('clockwise')
        ELEMENT(i,[1,2]) = ELEMENT(i,[2,1]);
        Ae(i) = - Ae(i);
    end
end


if 1==2
%% Plot the mesh for visualization

    figure(11);clf;
%     set(gcf,'Units', 'pixels','Position', [20 20 500 800] );

    % Plot the mesh
    trimesh(ELEMENT,XY(:,1),XY(:,2),'LineWidth',1,'Color',[1 1 1]*0.4)

%     % Display the element number
%     for i=1:Ne
%         text(ELEMENT_CENTER(i,1),ELEMENT_CENTER(i,2),['(' num2str(i) ')'],'FontWeight','bold','FontSize',10); 
%     end
% 
%     % Display the node number
%     for i=1:Nd
%         text(XY(i,1),XY(i,2),num2str(i),'color','r','LineWidth',2,'FontSize',16); 
%     end

    % axis([-hole_radius plate_width/2+hole_radius  -hole_radius plate_length/2+hole_radius ]);
    axis equal
    axis off
    set(gcf, 'color', 'w');
    
%     pause
end

