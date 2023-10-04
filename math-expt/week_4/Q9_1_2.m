clear all;
iteration=10;

origin=[0];
degress=[pi/2];
graph=[0,i];

for count=1:iteration
    new_degrees=[];
    new_origin=[];
    for j=1:length(origin)
        [new_graph, nexts, next_degrees] = make_plot(origin(j), degress(j), (1/3)^(count-1));
        new_degrees = [new_degrees, next_degrees];
        new_origin = [new_origin, nexts];
        graph = [graph, new_graph];
    end
    degress = new_degrees;
    origin = new_origin;
end

X=zeros(3*length(graph)/2,1);
Y=zeros(3*length(graph)/2,1);
for i=1:length(graph)/2
    X(3*i-2)=real(graph(2*i-1));
    Y(3*i-2)=imag(graph(2*i-1));
    X(3*i-1)=real(graph(2*i));
    Y(3*i-1)=imag(graph(2*i));
    X(3*i)=NaN;
    Y(3*i)=NaN;
end
plot(X,Y,'-');
axis equal;


function [a,b,c,d,e,f] = make_points(origin, degree, size)
    a = origin;
    b = origin + size * exp(i * degree);
    c = (2 * a + b) / 3;
    d = (a + 2 * b) / 3;
    e = c + sqrt(3) / 6 * size * exp(i * (degree + pi / 3));
    f = d + sqrt(3) / 6 * size * exp(i * (degree - pi / 3));
end

function [graph, nexts, degrees] = make_plot(origin, degree, size)
    [a,b,c,d,e,f] = make_points(origin, degree, size);
    graph = [[a,b],[c,e],[d,f]];
    nexts = [c,d,b];
    degrees = [degree + pi / 3, degree - pi / 3, degree];
end