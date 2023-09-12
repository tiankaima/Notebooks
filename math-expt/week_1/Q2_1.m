disp("Task 1");

S = @(n) 3*2^(n-1)*sin(pi/(3*2^(n-1)));

for n=1:30
    sides=6*2^(n-1);
    upper_bound=S(n);
    lower_bound=2*S(n)-S(n-1);
    fprintf('[n=%d]:\n Sides=%d\n Upper Bound=%.20f\n Lower Bound=%.20f\n', n, sides, upper_bound, lower_bound);
end

%%
disp("Task 2");

S = @(n) 3*2^(n-1)*sin(pi/(3*2^(n-1)));

for n=1:30
    sides=6*2^(n-1);
    guess=4/3*S(n)-1/3*S(n-1);
    fprintf('[n=%d]\n Sides=%d\n Approx=%.20f\n', n, sides, guess);
end

%%
disp("Task 3");

y_0 = 1/sqrt(2);
alpha_0 = 1/2;

y=[y_0];
alpha=[alpha_0];

for i=1:30
    y(i+1) = (1-sqrt(1-y(i)^2))/(1+sqrt(1-y(i)^2));
    alpha(i+1) = (1+y(i+1))^2*alpha(i)-2^(i)*y(i+1);

    fprintf('[n=%.2d] %.30f\n', i, 1/alpha(i+1));
end