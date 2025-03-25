%ex1
% t=-9:0.1:9;
% t1=find(t>=-9&t<-3);
% t2=find(t>=3&t<=9);
% t3=find(t>=-3&t<3);
% y1=sin(5*t(t1));
% y2=sin(5*t(t2));
% y3=cos(t(t3))-cos(3)-sin(15);
% 
% plot(t1,y1,'b-',t2,y2,'r-',t3,y3,'y-')


% t=-3:0.1:3;
% f=sin(pi.*t).*cos(pi.*t);
% g=sin(pi.*t+1).*cos(pi.*t+1);
% plot(t,f,'m--',t,g,'cs-')

%ex2 
% t=0:0.1:6*pi;
% f=sqrt(sin(t)+t.^2);
% polar(t,f,'g-')

%ex3
% t=1:0.1:5;
% f=exp(3*t);
% loglog(t,f,'g-')