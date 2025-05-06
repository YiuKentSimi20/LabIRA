syms a b c d

kp=35;
Ra=4.2;
La=14.28*10^-3;
ke=0.33;
km=0.33;
kEM=0.01;
J=0.71*10^-3;

s=tf('s');
Hyu=kp*km*kEM/(La*J*s^2 + Ra*J*s + km*ke);

Hyud=c2d(Hyu,0.01,'zoh') %discretizarea functiei de tranfer

[B,A]=tfdata(Hyud,'v');
[Ad,Bd,Cd,Dd]=tf2ss(B,A)

C=ctrb(Ad,Bd);
rank(C)

S=[a b;c d];

Q=[1 0;0 1];
R=0.1;
AdT = transpose(Ad);
BdT = transpose(Bd);


aux = AdT*S*Ad-S-AdT*S*Bd*(R+BdT*S*Bd)^-1*BdT*S*Ad+Q

Ec = vpa(aux)






