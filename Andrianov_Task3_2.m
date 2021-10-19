clear;
clc;

syms a x t T phi(x) psi(x) sol(x, t);

% Task conditions
a = 1 / 3;
phi(x) = 0;
psi(x) = piecewise((-3 <= x) & (x <= 3) , ceil(x / 2), ...
    x > 3, 0, x < -3, 0);

% D'Alembert equation
sol(x,t) = 1 / 2 * (phi(x + a * t) + phi(x - a * t)) + 1 / (2 * a)...
    * int(psi(x), x, x - a * t, x + a * t);

% Graph
x1 = -14;
x2 = 14;
T = 100;
xpl = linspace(x1, x2);
for j=0:0.5:T
    sol_t = subs(sol, t, j);
    final_sol = subs(sol_t, x, xpl);
    plot([x1 + x2, x1 + x2], [x1 + 1, x2 - 1], '--k',...
        [x1, x2], [x1 + x2, x1 + x2], '--k', xpl, final_sol, '-r');
    grid;
    pause(0.0001);
end