function A = f_tri_area(p,t)

% area is half of the determinate of the cross product of two edge vector
d12 = p(t(:,2),:)-p(t(:,1),:);
d13 = p(t(:,3),:)-p(t(:,1),:);
A = (d12(:,1).*d13(:,2)-d12(:,2).*d13(:,1))/2; 

end     