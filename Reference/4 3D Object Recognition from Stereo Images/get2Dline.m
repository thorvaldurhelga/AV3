% computes the r*ct + c*st + b = 0 from a line that goes thru
% point m with direction a

function [ct,st,b] = get2Dline(a,m)
     ct = -a(2);
     st = a(1);
     b = -(m(1)*ct + m(2)*st);
