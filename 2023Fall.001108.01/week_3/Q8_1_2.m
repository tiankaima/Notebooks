% for t = 1..10, draw abs(xy) = t on xy plane

for t=1:50
    ezplot(@(x,y) abs(x*y)-t,[-10,10,-10,10]);
    hold on;
end
axis equal;
hold off;
