p_list = [0, -1, 0.11, -0.10281, -1.25];
q_list = [1, 0, 0.66, 0.95723, -0.01];

draw_julia_sets(p_list, q_list);


function draw_julia_sets(p_list, q_list)
    figure('Name', 'Julia set', 'Position', [0, 0, 1200, 800], "NumberTitle", "off");
    for i = 1:5
        subplot(2, 3, i);
        julia_set(p_list(i), q_list(i));
    end
end

function julia_set(p, q)
    M = 2;
    N = 50;
    resolution = 500;
    K = 16;
    assert(M >= sqrt(p^2 + q^2));

    mu = p + 1j * q;
    x = linspace(-M, M, resolution);
    y = linspace(-M, M, resolution);
    [X,Y] = meshgrid(x, y);
    Z = X + 1j * Y;

    J = zeros(resolution, resolution);
    MASK = true(resolution, resolution);

    for i = 1:N
        Z = Z.^2 + mu;
        J = J + (abs(Z) < 4) .* MASK;
        MASK = (abs(Z) < 4) .* MASK;
        Z(~MASK) = 0;
    end

    J = mod(J, K);

    imagesc([-M, M], [-M, M], abs(J), [0 K]);
    axis equal;
    colormap(jet);
    title(sprintf('p = %.2f, q = %.2f', p, q));
    axis off;
    colorbar;
end