q=0.065;
Z=20;
K=20;               % conductivity
TT=4;
times=100;
dt=TT/times;
n=200;
delz=Z/(n-1);
z=0:delz:Z;
A=zeros(n,n);
    K2=0.3*K;
    alpha=K*dt/(delz*delz);
%A(ii,ii)=1+2*alpha;
%A(ii,ii-1)=-alpha;
%A(ii,ii+1)=-alpha;
% for ii=2:n-1
%     if ii<n/4
%    
% alpha=K*dt/(delz*delz);
% A(ii,ii)=1+2*alpha;
% A(ii,ii-1)=-alpha;
% A(ii,ii+1)=-alpha;
%     elseif ii>n/4
% 
%         alpha3=K2*dt/((delz*delz));
% A(ii,ii)=1+2*alpha3;
% A(ii,ii-1)=-alpha3;
% A(ii,ii+1)=-alpha3;
%  elseif ii==n/4
%    
%       alpha2=(K+K2)*dt/((delz*delz)*2);
%      %    alpha2=2*K*K2*dt/((delz*delz)*(K+K2));
% A(ii,ii)=1+2*alpha2;
% A(ii,ii-1)=-K*dt/(delz*delz);
% A(ii,ii+1)=-K2*dt/(delz*delz);
%      
%     end
%end
a=1+ones(1,n)*2*alpha;
b=-ones(1,n-1)*alpha;
A=diag(a,0)+diag(b,-1)+diag(b,1);
A(1,1)=1;
A(1,2)=0;
A(n,n-1)=0;
A(n,n)=1;
upperBC = 20;    % set temp BCs, in degrees
lowerBC = 20;
B=zeros(n,1);
B(1:n) = 10;
%line(T,z);
axis ij;
xlabel('temperature');
ylabel('Depth');
title('Geothermal Temps');
for ii=1:dt:TT
    B(1) = 10*(1+sin(2*pi*ii));
           %BC
    T=inv(A)*B;
    h=plot(B,z);
    axis ij;
    hold on;
     pause(0.1);
      %  delete(h);
        B=T;
end
