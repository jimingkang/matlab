%Solve a Turing model system of equations in 2-D space over time. Apply
%Euler¡¯s Method to a semi-discretized Reaction-Diffusion system.
%clear all
%Grid size
Tf=1000;
a=-1; % Lower boundary
b=1; % Upper boundary
M=50; % M is the number of spaces between points a and b.
dx=0.04; %(b-a)/M; % dx is delta x
dy=0.04; %(b-a)/M;
x=linspace(a,b,M+1); % M+1 equally spaced x vectors including a and b.
y=linspace(a,b,M+1);
%Time stepping
dt=0.08; %100*(dx^2)/2; % dt is delta t the time step
N=Tf/dt; % N is the number of time steps in the interval [0,1]
%Constant Values
D=0.516; % D is the Diffusion coefficient Du/Dv
delta=0.0021; % sizes the domain for particular wavelengths
alpha=0.899; % a is alpha, a coefficient in f and g (-a is gamma)
beta=-0.91; % b is beta, another coefficient in f and g
r1=3.5; % r1 is the cubic term
r2=0; % r2 is the quadratic term
gamma=-alpha; % g is for gamma
%pre-allocation
unp1=zeros(M+3,M+3);
vnp1=zeros(M+3,M+3);
%Initial Conditions
un=-0.5+rand(M+3,M+3); %Begin with a random point between [-0.5,0.5]
vn=-0.5+rand(M+3,M+3);
for n=1:N
    for i=2:M+2
    un(i,1)=un(i,3); %Boundary conditions on left flux is zero
    un(i,M+3)=un(i,M+1); %Boundary conditions on right
    vn(i,1)=vn(i,3);
    vn(i,M+3)=vn(i,M+1);
    end
    for j=2:M+2
    un(1,j)=un(3,j); %Boundary conditions on left
    un(M+3,j)=un(M+1,j); %Boundary conditions on right
    vn(1,j)=vn(3,j);
    vn(M+3,j)=vn(M+1,j);
    end
    for i=2:M+2
        for j=2:M+2
        %Source function for u and v
        srcu=alpha*un(i,j)+vn(i,j)*0.08;
        srcv=beta*vn(i,j)+gamma*vn(i,j);
        %srcu=alpha*un(i,j)*(1-r1*vn(i,j)^2)+vn(i,j)*(1-r2*un(i,j));
        %srcv=beta*vn(i,j)*(1+(alpha*r1/beta)*un(i,j)*vn(i,j))+un(i,j)*(gamma+r2*vn(i,j));
        uxx=(un(i-1,j)-2*un(i,j)+un(i+1,j))/dx^2; %Laplacian u
        vxx=(vn(i-1,j)-2*vn(i,j)+vn(i+1,j))/dx^2; %Laplacian v
        uyy=(un(i,j-1)-2*un(i,j)+un(i,j+1))/dy^2; %Laplacian u
        vyy=(vn(i,j-1)-2*vn(i,j)+vn(i,j+1))/dy^2; %Laplacian v
        Lapu=uxx+uyy;
        Lapv=vxx+vyy;
        unp1(i,j)=un(i,j)+dt*(D*delta*Lapu+srcu);
        vnp1(i,j)=vn(i,j)+dt*(delta*Lapv+srcv);
        end
    end
    un=unp1;
    vn=vnp1;
% Graphing
    if mod(n,6250)==0
    %subplot(2,1,2)
    hdl = surf(x,y,un(2:M+2,2:M+2));
    set(hdl,'edgecolor','none');
    axis([ -1, 1,-1,1]);
    %caxis([-10,15]);
    view(2);
    colorbar;
    fprintf('Time t = %f\n',n*dt);
    ch = input('Hit enter to continue :','s');
        if (strcmp(ch,'k') == 1)
        keyboard;
        end
    end
end