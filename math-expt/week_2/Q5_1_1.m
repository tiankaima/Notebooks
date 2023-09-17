tic
N=500;
x=2:N;

for i=2:N-1
    % remove i*2 i*3 ... in x
    j=2;
    while j*i <= N
        x(j*i-1) = 0;
        j=j+1;
    end
end

x = x(x~=0);
disp(num2str(x));
toc
clear all;