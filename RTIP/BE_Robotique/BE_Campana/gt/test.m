% Programme principal

clear all;
close all

A=[2 2];
B=[-2 -2 ];
Vmax=2;
VAB=1;
Amax=1;

[t,dt,tf,qplus,gamma]= deplacer(A,B,'droite',VAB,Vmax,Amax)