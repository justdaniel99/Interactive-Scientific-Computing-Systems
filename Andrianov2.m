tic

% All the fields and data clearing
clear;
clc;

% (6) Constant values
N = 10;
a = 0;
b = 10;

% Grid
x = linspace(a, b, N);

% Grid step
h = x(2)-x(1);

% f(x)
f = @(t) 2.*cosh(t);

% (1) Analytical solution
y_exact = @(t) sinh(t)+t.*cosh(t);

% (2) Solving ODE with MatLab
[t,y_diff] = ode23(@vdp1, x,[0; 2]);

% (3) Recurrence formulas
y(1)=f(a);
y(2)=f(x(2))/(1-h.*kernel(x(2),x(2)));
for n=3:N
    sum_K = sum(kernel(x(n),x(2:(n-1))).*y(2:(n-1)));
    y(n)=(f(x(n))+h.*sum_K)/(1-h.*kernel(x(n),x(n)));
end

% (4) Interpolation polynomial of degree 8 (for recurrence formulas points)
interpol = polyfit(x, y, 8);
y_interp = polyval(interpol, x);

% (5) Inaccuracy
delta = b / 10;
d = 0.5;

y_d(1)=f(a);
y_d(2)=f(x(2))/(1-h.*delta_kernel(x(2),x(2)));
for n=3:N
    sum_K = sum(delta_kernel(x(n),x(2:(n-1))).*y_d(2:(n-1)));
    y_d(n)=(f(x(n))+h.*sum_K)/(1-h.*delta_kernel(x(n),x(n)));
end

pol = polyfit(x,y_d,4);
y_inacc = polyval(pol, x);

% (5) Disparity
% Vectors normalization
n1 = normalize(y_exact(x));
n2 = (normalize(y_diff(:,1)))';
n3 = normalize(y_interp);
n4 = normalize(y_inacc);

% Euclidean norms of normalized vectors
dif1 = norm(n1-n3);
dif2 = norm(n1-n4);
dif3 = norm(n2-n3);
dif4 = norm(n2-n4);

% (7) Functions graphs
plot(t, y_diff(:, 1), '-b', x, y_exact(x),':r', x, y_interp, '-g', ...
    x, y_inacc, 'm', x, y_interp, '.k', 'MarkerSize', 4);

title('Credit Test Assignment №1');
xlabel('x');
ylabel('y');
legend('y_{diff}', 'y_{exact}', 'y_{interp-8}', 'y_{inaccuracy}', ...
    '(x_k,y_k)');

toc