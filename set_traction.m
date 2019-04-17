function Traction = set_traction(XY,ELEMENT,para)
% Set traction equal to a given value in the outer rim with width rim_width
Nd= size(XY, 1);

r=sqrt(sum(XY.*XY,2));
r_colony = para.colony_diameter/2;
Traction = para.given_traction*ones(Nd,1).*heaviside(r-(r_colony-para.rim_width));


%% plot it for checking
figure(22)
plot_heat_map(XY,ELEMENT,Traction,'jet','yes_colorbar',-1);
axis equal % this command needs to be placed before axis([]), otherwise, axis will move
title('Traction');