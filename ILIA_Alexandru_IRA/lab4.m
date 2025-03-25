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

s=tf('s');

%1-------------------------------------
Hyu=(kp*km*kEM)/(J*La*s^2 + J*Ra*s + km*ke)





%Hyu2=tf([kp*km*kEM], [J*La  J*Ra  km*ke])

Hyud=c2d(Hyu,Te,'zoh')

%2--------------------------------------
Hm=w0^2/(s^2+2*ze*w0*s+w0^2);

Hmd=c2d(Hm,Te,'zoh')

[num, den]=tfdata(Hmd,'v')  

Am=den
syms q
Am2=poly2sym([1 -1.2573 0.4630],q)

