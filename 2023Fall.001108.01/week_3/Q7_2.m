close all;clc;clear;
sep = 0.05;
sides = 12;
steps = 2000;

k = 0:sides;
x = cos(2*pi*k/sides);
y = sin(2*pi*k/sides);

x_history = [];
y_history = [];

for i=1:steps
    x_history = [x_history; x];
    y_history = [y_history; y];

    if mod(i,2) == 1
        fill(x, y, 'b')
    else
        fill(x, y, 'w')
    end
    hold on

    x = x * (1-sep) + [x(2:end) x(2)] * sep;
    y = y * (1-sep) + [y(2:end) y(2)] * sep;
end
daspect([1 1 1])
hold off



% just the curve:
x = cos(2*pi*k/sides);
y = sin(2*pi*k/sides);
plot(x, y, 'k', 'LineWidth', 2)
hold on

for k=1:sides
    plot(x_history(:,k), y_history(:,k), 'k', 'LineWidth', 2)

    x_history(:,k);
    x_history(:,k+1);
    x = [flipud(x_history(:,k+1)); x_history(:,k)];
    y = [flipud(y_history(:,k+1)); y_history(:,k)];

    if mod(k,2) == 1
        fill(x, y, 'b')
    else
        fill(x, y, 'w')
    end
    hold on
end
daspect([1 1 1])
hold off