<<<<<<< HEAD
function [T] = MatriceHomogeneLiaison2(a,alpha,r,theta)

%translation selon x(i-1) de a
T1=MatriceHomogeneElementaire('t','x',a);
%rotation autour de x(i-1) de alpha
T2=MatriceHomogeneElementaire('r','x',alpha);
%translation selon zi de r
T3=MatriceHomogeneElementaire('t','z',r);
%rotation selon zi de theta
T4=MatriceHomogeneElementaire('r','z',theta);

T=T1*T2*T3*T4;
=======
function [T] = MatriceHomogeneLiaison2(a,alpha,r,theta)

%translation selon x(i-1) de a
T1=MatriceHomogeneElementaire('t','x',a);
%rotation autour de x(i-1) de alpha
T2=MatriceHomogeneElementaire('r','x',alpha);
%translation selon zi de r
T3=MatriceHomogeneElementaire('t','z',r);
%rotation selon zi de theta
T4=MatriceHomogeneElementaire('r','z',theta);

T=T1*T2*T3*T4;
>>>>>>> 25b88a0d14b548b32fefd94b9a51113781a0067a