s_list = [0.5 + 0.5 * 1j, 1j, 0.5j, 0.2 + 0.5 * 1j];

figure("Name", "IFS", "Position", [0, 0, 1200, 250], "NumberTitle", "off");
for i = 1:length(s_list)
    subplot(1, 4, i);
    axis equal;
    axis off;
    draw_omega(s_list(i));
    hold off;
end

function val = omega1(s, Z)
    val = s * Z + 1;
end

function val = omega2(s, Z)
    val = s * Z - 1;
end

function val = omega(s, Z)
    if rand < 0.5
        val = omega1(s, Z);
    else
        val = omega2(s, Z);
    end
end

function draw_omega(s, n)
    if nargin < 2
        n = 10000;
    end

    Z = zeros(n, 1);

    for i = 2:n
        Z(i) = omega(s, Z(i - 1));
    end

    scatter(real(Z), imag(Z),5);
    hold on;
    title(['s=', num2str(s)]);
end