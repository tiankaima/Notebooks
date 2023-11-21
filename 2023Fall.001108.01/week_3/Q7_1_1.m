histories = [];
filenames = [
  "math-expt/week_3/imgs/Q7_1_1.gif",
  "math-expt/week_3/imgs/Q7_1_2.gif",
  "math-expt/week_3/imgs/Q7_1_3.gif"
];

for t = 0:0.02:4
    a = calculate(t);
    b = calculate(t-1)+[1 0];
    c = calculate(t+2)-[2 0];
    d = calculate(t+1)-[1 0];

    p = (2*a + b)/3;
    q = (a + 2*b + 3*c + 4*d)/10;
    r = (a+b-0.3*c-0.3*d)/1.4;

    points_to_plot = [p; q; r];
    sqaure_points = [a; b; c; d; a];

    histories = cat(3, histories, points_to_plot);

    for i=1:3
      plot(sqaure_points(:,1), sqaure_points(:,2), 'k-');
      hold on

      x = reshape(histories(i,1,:), 1, []);
      y = reshape(histories(i,2,:), 1, []);
      plot(x,y,'r.');
      hold off

      grid on;
      daspect([1 1 1])
      axis([-0.5 5.5 -0.5 2.5])
      drawnow;
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if t == 0
        imwrite(imind,cm,filenames(i),'gif', 'Loopcount',inf, 'DelayTime',0.001);
      else
        imwrite(imind,cm,filenames(i),'gif','WriteMode','append', 'DelayTime',0.001);
      end
    end
end




% p = p(t)
function p = calculate(t)
    % return (x(t),y(t))
    p = [calculate_x(t), calculate_y(t)];
end

% x = x(t)
function x = calculate_x(t)
  speed = pi/2;
  base = (t - mod(t,4));
  t = mod(t, 4);
  if t<1
    x = 1 - cos(speed*t);
  elseif t<2
    x = 2 - sqrt(2) * cos(speed*(t-1) + pi/4);
  elseif t<3
    x = 3 + sin(speed*(t-2));
  else
    x = 4;
  end
  x = x + base;
end

% y = y(t)
function y = calculate_y(t)
  speed = pi/2;
  t = mod(t, 4);
  if t<1
    y = sin(speed*t);
  elseif t<2
    y = sqrt(2) * sin(speed*(t-1) + pi/4);
  elseif t<3
    y = cos(speed*(t-2));
  else
    y = 0;
  end
end