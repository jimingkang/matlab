
function  plot_results(para,P,R,traction,migration_i,ELEMENT,XY)  

figure(1);
clf

% % scrsz = get(0,'ScreenSize'); % [left, bottom, width, height]
% % set(gcf,'Units', 'pixels','Position', [50+scrsz(1) 50+scrsz(2) 0.8*scrsz(3) 0.6*scrsz(4)] );
set(gcf,'Units', 'pixels','Position', [10 200 900 300] );

title_fontsize = 12;


%%
subplot(1,2,1)
cla
 
plot_heat_map(XY,ELEMENT,P,'jet','yes_colorbar',-1);
axis equal % this command needs to be placed before axis([]), otherwise, axis will move
title('BMP','FontSize' , title_fontsize ,'FontWeight' , 'bold');
set(gca,'XTick',[],'YTick',[],'Box','on')

%%
subplot(1,2,2)
cla
 
plot_heat_map(XY,ELEMENT,R,'jet','yes_colorbar',-1);

axis equal % this command needs to be placed before axis([]), otherwise, axis will move
title('NOG','FontSize' , title_fontsize ,'FontWeight' , 'bold');
set(gca,'XTick',[],'YTick',[],'Box','on')

