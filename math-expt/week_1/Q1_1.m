syms k
f = @(n,x) symsum((-1)^k*x.^(2*k+1)/factorial(2*k+1),k,0,n+1);
delta = 1e-10;
div = @(f,x) (f(x+delta)-f(x-delta))/(2*delta);
newton_iteration = @(f, x_n) x_n - f(x_n) / div(f,x_n);
steps = 20;
digits_to_keep = 50;

for n=1:10
    f_tmp = @(x) f(n,x);
    x=3.0;
    for c=1:steps
        x = round(newton_iteration(f_tmp, x), digits_to_keep);
    end
    fprintf('[%2.d]: %.50f\n', n, x);
end