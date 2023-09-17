tic
N=500;
x=2:N;
k=100;
s=rng();

for n=3:N
    for i=1:k
        % pick random a
        a = randi([2,n-1],1,1);

        % if n mod a == 0, n is not prime
        if mod(n,a) == 0
            x(n-1) = 0;
            break;
        end

        % calc J=a^(n-1)/2 mod n
        J = mod(sym(a)^((n-1)/2),n);

        % if j!=+-1, n is not prime
        if J ~= 1 && J ~= n-1
            x(n-1) = 0;
            break;
        end
    end
end

x = x(x~=0);
disp(num2str(x));
toc
clear all;