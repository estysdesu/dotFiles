clc
clear all
syms a y(t)
eqn = diff(y,t) == -(5*t+8)/(5*y-5);
pretty(dsolve(eqn));
%%cond = y(0) == 9;
%%pretty(dsolve(eqn,cond));
