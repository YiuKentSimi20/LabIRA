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


I2=[1 0; 0 1];
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


Q=[1, 0; 0, 1]
R=0.1;
Ad=[0.7332, -0.0528; 1, 0]
Bd = [1; 0]

[Kopt, S, e] = dlqr(Ad, Bd, Q, R);

disp('S =')
disp(S)

disp('Kopt=')
disp(Kopt)
K=-Kopt
z1=0.9048;
z2=0.9139;
P=[z1; z2];

K0=-place(Ad,Bd,P)


syms a b c d ki1 ki2
Maux=[a b;c d];
Kiaux = [ki1 ki2];

for i = 1:5

    disp('Iteratia')
    disp(i)
    disp('-------------------------')
    
    ec = Maux-Q-K0'*R*K0-(Ad+Bd*K0)'*Maux*(Ad+Bd*K0);

    ec=solve(ec);
    a1=double(ec.a);
    b1=double(ec.b);
    c1=double(ec.c);
    d1=double(ec.d);


    M = [a1 b1;c1 d1]
    
    ec2 = Kiaux+(R+Bd'*M*Bd)^-1*Bd'*M'*Ad;
    ec2=solve(ec2);
    Ki = [double(ec2.ki1) double(ec2.ki2)]
    K0 = Ki;
    
    
end


X = eye(2)-Ad-Bd*K
eta = 1/(Cd*(inv(X)*Bd))

