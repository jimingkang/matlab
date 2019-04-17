%Solve a Turing model system of equations in 2-D space over time. Apply %Euler¡¯s Method to a semi-discretized Reaction-Diffusion system.
%clear all
%Grid size
Tf=1000000; a=-1; % Lower boundary 
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

un(i,