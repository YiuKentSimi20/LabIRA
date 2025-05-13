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
La=14.28 * 10^(-3);
J=0.71 * 10^(-3);

s=tf('s');
Hpc=kp*km*kEM/(La*J*s^2+Ra*J*s+km*ke);

%discretizarea functiei de transfer
Hpcd=c2d(Hpc,0.01,'zoh');

[B,A]=tfdata(Hpcd,'v');
%MM-ISI
[Ad,Bd,Cd,Dd]=tf2ss(B,A)

%pentru controlabilitate
C=ctrb(Ad,Bd);
rank(C)

syms a b c d
Q=[1, 0; 0, 1]
R=0.1;
Ad=[0.7332, -0.0528; 1, 0]
Bd = [1; 0]

[Kopt, S, e] = dlqr(Ad, Bd, Q, R);

disp('S =')
disp(S)

disp('Kopt=')
disp(Kopt)

z1=0.9048;
z2=0.9139;
P=[z1; z2];

K0=-place(Ad,Bd,P)
