Te=0.01;

%valorile modelului de referinta
ze=0.7;
w0=55;

%valorile parametrilor PC
kp=35;
ke=0.33;
km=0.33;
kEM=0.01;
Ra=4.2;
La=14.28*10^-3;
J=0.71*10^-3;

% ------------------date_init.m----------------------- %
s=tf('s');
pc=2/(s^2+7*s+6);
Ts=0.1;
pcd=c2d(pc,Ts,'zoh')
pcdf=filt(pcd.num{1},pcd.den{1},Ts);B=pcd.num{1}(2:3);A=pcd.den{1};
nA=2;nB=1; % forma ARX A(q^-1)*y(k)=B(q^-1)*u(k-1)
Tsim=20;
N=(Tsim/Ts);
Orizont=3;
Q=eye(Orizont);lambda=0.0001;
R=zeros(N+Orizont,1);R(21:end)=1;
% calcul forma matriceala predictor
% A=[1 a1*q^-1 a2*q^-2]=[1 a1 a2],B=[b0 b1*q^-1]
% predictor de ordin 3
e30=1;
E3=[e30 -A(2)*e30 A(2)*A(2)*e30-A(3)*e30]; %E3=[e30 e31 e32]
F3=[-A(2)*E3(3)-A(3)*E3(2) -A(3)*E3(3)]; %F3=[f30 f31];
tmp=conv(E3,B);
G3=tmp(1:3);H3=tmp(4);
% predictor de ordin 1
e10=1;E1=e10;F1=-e10*[A(2) A(3)];G1=B(1);H1=B(2);
%predictor de ordin 2
e20=1;E2=[e20 -e20*A(2)];F2=[-e20*A(3)-E2(2)*A(2) -E2(2)*A(3)];
tmp=conv(E2,B);G2=tmp(1:2);H2=tmp(3);
P=[G1 0 0;fliplr(G2) 0;fliplr(G3)]; PSI=[F1 H1;F2 H2;F3 H3];
% to clear persistent vars in Fcn, call >>clear 'FcnName' in prompt
clear myMPC
%-----------------------------------------------------------%