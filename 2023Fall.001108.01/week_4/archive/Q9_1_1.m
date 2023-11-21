clear all;
iteration=5;

origin=[0];
graph=[[0,1],[0,0.5+0.5*sqrt(3)*i],[0.5+0.5*sqrt(3)*i,1]]

for count=1:iteration
    new_origin=[];
    for j=1:length(origin)
        [new_graph, nexts] = make_plot(origin(j), (1/2)^(count-1));
        new_origin = [new_origin, nexts];
        graph = [graph, new_graph];
    end
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


function [a,b,c,d,e,f] = make_points(origin, size)
    a = origin;
    b = origin + (size / 2 + size / 2 * sqrt(3) * i);
    c = origin + size;

    d = (a + b) / 2;
    e = (b + c) / 2;
    f = (c + a) / 2;
end

function [graph, nexts] = make_plot(origin, size)
    [a,b,c,d,e,f] = make_points(origin, size);
    graph = [[d,e],[e,f],[f,d]];
    nexts = [a,d,f];
end