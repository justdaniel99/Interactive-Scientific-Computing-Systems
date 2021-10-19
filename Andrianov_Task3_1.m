clear;
clc;

syms x y(x) Dy D2y;

% given function
F = 2 * x^2 - 8 * x * y + 4 * y^2 + Dy^2;

% initial conditions
x1 = -1; 
y1 = 3;
x2 = 1;
y2 = 1;
cond1 = y(sym(x1)) == sym(y1);
cond2 = y(sym(x2)) == sym(y2);
conds = [cond1 cond2];

% derivatives
dFdy = diff(F, y); %F_y
dfddery = diff(F, Dy); %F_y'
dfdderydx = diff(dfddery, x); %F_y'_x
dfdderydy = diff(dfddery, y); %F_y'_y
dfdderyddery = diff(dfddery, Dy); %F_y'_y'

% Euler equation
euler = dFdy - (dfdderydx + dfdderydy * Dy + dfdderyddery * D2y)==0;

% Task solution
constsol = dsolve(char(euler), conds, 'x')

% Graph
xpl = linspace(x1, x2);
ypl = subs(constsol, x, xpl);
plot(xpl, ypl, '-r');
title('First Task');
xlabel('x');
ylabel('y(x)');