tic
N=500;
x=2:N;

for n=3:N
    if mod(n,2) == 0
        x(n-1) = 0;
        continue;
    end

    a=1;
    while a<70*log(n)^2
        if mod(sym(a)^((n-1)/2) - jacobiSymbol(a,n),n) == 0
            a=a+1;
        else
            x(n-1) = 0;
            break;
        end
    end
end

x = x(x~=0);
disp(num2str(x));
toc
clear all;