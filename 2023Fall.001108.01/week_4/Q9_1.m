sierpinski_input_string = 'F-F-F';
sierpinski_iter_rules = containers.Map({'F', 'G'}, {'F-G+F+G-F', 'GG'});
sierpinski_angle_base = pi / 2;

sierpinski_n_list = [2, 3, 5];
figure('Name', 'Sierpinski Triangle','Position',[100 100 1000 300], "NumberTitle", "off");
for i = 1:3
    subplot(1, 3, i);
    axis equal;
    axis off;
    daspect([1 1 1]);
    draw(sierpinski_input_string, sierpinski_iter_rules, @sierpinski_process, sierpinski_angle_base, n_list(i));
    title(sprintf('n=%d', n_list(i)));
    hold off;
end

koch_axiom = 'F';
koch_iteration_rules = containers.Map('F', 'F+F-F-F+F');
koch_angle_base = 0;

koch_n_list = [2, 4, 6];
figure('Name', 'Koch Curve','Position',[100 100 1000 300], "NumberTitle", "off");
for i = 1:3
    subplot(1, 3, i);
    axis equal;
    axis off;
    daspect([1 1 1]);
    draw(koch_axiom, koch_iteration_rules, @koch_process, koch_angle_base, koch_n_list(i));
    title(sprintf('n=%d', koch_n_list(i)));
    hold off;
end

fractal_axiom = 'X';
fractal_iteration_rules = containers.Map({'X', 'F'}, {'F+[[X]-X]-F[-FX]+X', 'FF'});
fractal_angle_base = pi / 4;

fractal_n_list = [2, 4, 6];
figure('Name', 'Fractal Plant','Position',[100 100 1000 300], "NumberTitle", "off");
for i = 1:3
    subplot(1, 3, i);
    axis equal;
    axis off;
    daspect([1 1 1]);
    draw(fractal_axiom, fractal_iteration_rules, @fractal_process, fractal_angle_base, fractal_n_list(i));
    title(sprintf('n=%d', fractal_n_list(i)));
    hold off;
end


function [cur, angle, lines_to_draw] = sierpinski_process(c, cur, angle, lines_to_draw)
    if c == 'F'
        next = cur + exp(1i * angle);
        lines_to_draw = [lines_to_draw; cur next];
        cur = next;
    elseif c == 'G'
        next = cur + exp(1i * angle);
        cur = next;
    elseif c == '+'
        angle = angle + pi / 3 * 2;
    elseif c == '-'
        angle = angle - pi / 3 * 2;
    end
end

function [cur, angle, lines_to_draw] = koch_process(c, cur, angle, lines_to_draw)
    if c == 'F'
        next = cur + exp(1i * angle);
        lines_to_draw = [lines_to_draw; cur next];
        cur = next;
    elseif c == '+'
        angle = angle + pi / 2;
    elseif c == '-'
        angle = angle - pi / 2;
    end
end

function [cur, angle, lines_to_draw] = fractal_process(c, cur, angle, lines_to_draw)
    if c == 'F'
        next = cur + exp(1i * angle);
        lines_to_draw = [lines_to_draw; cur next];
        cur = next;
    elseif c == '+'
        angle = angle + deg2rad(25);
    elseif c == '-'
        angle = angle - deg2rad(25);
    end
end

function draw(input_string, iter_rules, process, angle_base, iter_count)
    lines_to_draw = [];  % x-y pairs of complex numbers
    rule = apply_rules(input_string, iter_rules, iter_count);
    cur = 0;
    angle = angle_base;
    angle_stack = [];
    position_stack = [];

    % To iterate over every character of a string in MATLAB, we split the string
    % into a cell array of single character strings
    rule_cell_array = cellstr(split(rule,''));
    for i = 1:length(rule_cell_array)
        c = rule_cell_array{i};
        if c == '['
            angle_stack = [angle_stack, angle];
            position_stack = [position_stack, cur];
        elseif c == ']'
            angle = angle_stack(end);
            angle_stack(end) = []; % remove the last element
            cur = position_stack(end);
            position_stack(end) = []; % remove the last element
        else
            [cur, angle, lines_to_draw] = process(c, cur, angle, lines_to_draw);
        end
    end

    % plotting the result
    for i = 1:size(lines_to_draw, 1)
        line = [real(lines_to_draw(i, 1)), real(lines_to_draw(i, 2));
                imag(lines_to_draw(i, 1)), imag(lines_to_draw(i, 2))];
        plot(line(1,:),line(2,:), 'Color', 'black');
        hold on;
    end
end

function result = apply_rules(input_string, iter_rules, iter_count)
    if iter_count == 0
        result = input_string;
        return;
    else
        input_cells = cellstr(split(input_string, ''));
        new_string = '';
        for i = 1:length(input_cells)
            ch = input_cells{i};
            if isKey(iter_rules, ch)
                new_string = strcat(new_string, iter_rules(ch));
            else
                new_string = strcat(new_string, ch);
            end
        end
    end
    result = apply_rules(new_string, iter_rules, iter_count - 1);
end