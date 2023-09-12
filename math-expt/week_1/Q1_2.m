n = 1:10000;
x = 1./n;
y = sin(n);
plot(x,y,'.')
hold on

for n=1:2000
    m = n + 44;
    pointN = [1/n, sin(n)];
    pointM = [1/m, sin(m)];

    plot([pointN(1),pointM(1)], [pointN(2),pointM(2)]);
    hold on
end
hold off

axis([0, 4*10^(-3), -1,1]);