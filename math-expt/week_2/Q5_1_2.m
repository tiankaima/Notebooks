tic
N=500;
x=2:N;

for i=2:N
    % determine if i is prime using [2:i-1], set x(i-1) to 0 if not
    for j=2:1:floor(sqrt(i))
        if mod(i,j) == 0
            x(i-1) = 0;
            break;
        end
    end
end

x = x(x~=0);
disp(num2str(x));
toc
clear all;