N=1000;
x=2:N;

for i=2:N
    for j=2:1:floor(sqrt(i))
        if mod(i,j) == 0
            x(i-1) = 0;
            break;
        end
    end
end
x = x(x~=0);

h1=figure(1);clf
hold on
xlim([0, N]);ylim([-1,1])
plot(x,0,'kx','markersize',10)
axis off
title('Prime Numbers [2,1000]')
clear all;