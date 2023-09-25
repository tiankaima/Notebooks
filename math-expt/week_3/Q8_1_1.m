x = linspace(-2,2,20);
y = x';
z = abs(x.*y);
h = surf(x,y,z);
set(h, 'FaceColor',[1 0 0], 'FaceAlpha', 0.2, 'EdgeAlpha', 0.1)
hold on;

t = -2:0.01:2;
plot3(t,t,t.^2,'b');
plot3(t,-t,t.^2,'b');
plot3(t,zeros(length(t)),zeros(length(t)),'r');
plot3(zeros(length(t)),t,zeros(length(t)),'r');
axis equal;
hold off;
