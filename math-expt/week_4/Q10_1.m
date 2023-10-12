draw_feigenbaum();

function val = f(r, x)
    val = r .* x .* (1 - x);
end

function val = s(r)
    x = rand(size(r));
    for i = 1:100
        x = f(r, x);
    end
    val = x;
end

function draw_feigenbaum()
    r = linspace(0, 4, 10000);
    x = s(r);
    scatter(r, x, 0.1, 'filled');
    title('Feigenbaum diagram');
end