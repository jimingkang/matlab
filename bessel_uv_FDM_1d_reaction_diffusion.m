% Simulating the 1-D Diffusion equation (Fourier's equation) by the
...Finite Difference Method(a time march)
% Numerical scheme used is a first order upwind in time and a second order
...central difference in space (both Implicit and Explicit)


%%
%Specifying Parameters

a=0.16;
b =-0.3;
c=0.1;
d=-0.17;
vis=0.03;            %Diffusion coefficient/viscosity
vis2=0.4;            %Diffusion coefficient/viscosity

%{
a=0.05;
b =-0.08;
c=0.1;
d=-0.08;
%}
vis=0.01;            %Diffusion coefficient/viscosity
vis2=0.5;            %Diffusion coefficient/viscosity

nx=50;               %Number of steps in space(x)
nt=1800;               %Number of time steps 
dt=0.02;              %Width of each time step
dx=2/(nx-1);         %Width of space step
x=0:dx:2;            %Range of x (0,2) and specifying the grid points
u=zeros(nx,1);       %Preallocating u
un=zeros(nx,1);      %Preallocating un

v=zeros(nx,1);       %Preallocating u
vn=zeros(nx,1);      %Preallocating un


vis=0.03;            %Diffusion coefficient/viscosity
vis2=0.4;            %Diffusion coefficient/viscosity
beta=vis*dt/(dx*dx); %Stability criterion (0<=beta<=0.5, for explicit)
beta2=vis2*dt/(dx*dx); %Stability criterion (0<=beta<=0.5, for explicit)
UL=0;                %Left Dirichlet B.C
UR=0;                %Right Dirichlet B.C
UnL=0;               %Left Neumann B.C (du/dn=UnL) 
UnR=0;               %Right Neumann B.C (du/dn=UnR) 

VL=0;                %Left Dirichlet B.C
VR=0;                %Right Dirichlet B.C
VnL=0;               %Left Neumann B.C (du/dn=UnL) 
VnR=0;               %Right Neumann B.C (du/dn=UnR) 

%%
%Initial Conditions: A square wave
for i=1:nx
    %if ((1.9<=x(i))&&(x(i)<=2))
     %   u(i)=2;
       %v(i)=2;
    %end
    if ((0<=x(i))&&(x(i)<=2))
        u(i)=20;
    end
end

%%
%B.C vector
bc=zeros(nx-2,1);
bc(1)=vis*dt*UL/dx^2; bc(nx-2)=UnR*vis*dt/dx;  %Dirichlet B.Cs
%bc2(1)=vis*dt*UL/dx^2; bc2(nx-2)=vis*dt*UR/dx^2;  %Dirichlet B.Cs
%bc(1)=0; bc(nx-2)=UnR*vis*dt/dx;  %Neumann B.Cs 
%bc2(1)=-VnL*vis2*dt/dx; bc2(nx-2)=VnR*vis2*dt/dx;  %Neumann B.Cs

%Calculating the coefficient matrix for the implicit scheme
E=sparse(2:nx-2,1:nx-3,1,nx-2,nx-2);
A=E+E'-2*speye(nx-2);        %Dirichlet B.Cs
A(1,1)=-1; A(nx-2,nx-2)=-1; %Neumann B.Cs
D=speye(nx-2)-(vis*dt/dx^2)*A;

%%
%Calculating the velocity profile for each time step
i=2:nx-1;
ii=[1:nx-2]';
for it=0:nt
   
    un=u;
    h=plot(x,u);       %plotting the velocity profile
    axis([0 2 0 3])
    title({['1-D Diffusion with \nu =',num2str(vis),' and \beta = ',num2str(beta)];['time(\itt) = ',num2str(dt*it)]})
    xlabel('Spatial co-ordinate (x) \rightarrow')
    ylabel('Transport property profile (u) \rightarrow')
    drawnow; 
    refreshdata(h)
    %Uncomment as necessary
    %-------------------
    %Implicit solution
    %{
    U=un;U(1)=[];U(end)=[];
    U=U+bc;
    U=D\U;
    %u=[UL;U;UR];                      %Dirichlet
    u=[U(1)-UnL*dx;U;U(end)+UnR*dx]; %Neumann
    %}
    %-------------------
    %Explicit method with F.D in time and C.D in space
    %{
    u(i)=un(i)+(vis*dt*(un(i+1)-2*un(i)+un(i-1))/(dx*dx));
    %}
    U=un;U(1)=[];U(end)=[];
    U=U+bc;
    %U=D\U;
    %u=[U(1)-UnL*dx;U;U(end)+UnR*dx];
    u=[UL;U;UR]; 
    u(i)=un(i)+(vis*dt*(un(i+1)-2*un(i)+un(i-1))/(dx*dx))+a*dt*un(i)+b*dt*un(i)+dt*(un(i+1)-un(i))/(dx)./ii;
     v(i)=vn(i)+(vis2*dt*(vn(i+1)-2*vn(i)+vn(i-1))/(dx*dx))+c*dt*un(i)+d*dt*vn(i)+dt*(vn(i+1)-vn(i))/(dx)./ii;
    
end


