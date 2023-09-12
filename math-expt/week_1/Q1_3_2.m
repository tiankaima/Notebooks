syms s x
S = int(1/s, s, 1, x);

%%

a = 0.1:0.01:10;
b = double(subs(S, x, a));

subplot(2,2,1)
plot(a,b);
subplot(2,2,2)
plot(a, log(a));

%%

steps=20;
delta=1e-3;

div = @(t) 1/t;
newton_iteration = @(x_n) x_n - log(x_n) * x_n;

x=3.0;
for c=1:steps
    x = round(newton_iteration(x), 50);
end
fprintf('$x_0$ = %.50f\n', x);