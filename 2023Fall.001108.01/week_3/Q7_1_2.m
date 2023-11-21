histories = [];
filenames = [
  "math-expt/week_3/imgs/Q7_1_4.gif",
  "math-expt/week_3/imgs/Q7_1_5.gif",
  "math-expt/week_3/imgs/Q7_1_6.gif"
];

for t = 0:0.2:100
    theta0 = 2*atan(0.1);
    a = calculate(t);
    b = calculate(t+1)* [cos(theta0), -sin(theta0); sin(theta0), cos(theta0)];
    c = calculate(t+2)* [cos(2*theta0), -sin(2*theta0); sin(2*theta0), cos(2*theta0)];
    d = calculate(t+3)* [cos(3*theta0), -sin(3*theta0); sin(3*theta0), cos(3*theta0)];

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
      plot(x,y,'r-');

      l=0:0.02:2*pi;
      x = 5*cos(l);
      y = 5*sin(l);
      plot(x,y,'k-');
      hold off

      grid on;
      daspect([1 1 1])
      axis([-5 5 -5 5])
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
  r = 5;
  theta0 = 2*atan(0.1);
  base = (t - mod(t,4));
  t = mod(t, 4);
  if t < 1
    p = r*[cos(theta0), sin(theta0)];
    k = - (0.5*pi - 0.5*theta0) - t * (0.5*pi - theta0);
    p = p + [cos(k), sin(k)];
  elseif t<2
    p = [r*cos(2*theta0), r*sin(2*theta0)];
    k = - (0.75*pi - 1.5*theta0) - (t-1) * (0.5*pi - theta0);
    p = p + sqrt(2)*[cos(k), sin(k)];
  elseif t<=3
    p = [r*cos(3*theta0), r*sin(3*theta0)];
    k = - (pi - 2.5*theta0) - (t-2) * (0.5*pi - theta0);
    p = p + [cos(k), sin(k)];
  else
    p = calculate(3);
  end

  % rotate the point around origin point by base * theta_0
  p = p * [cos(base*theta0), sin(base*theta0); -sin(base*theta0), cos(base*theta0)];
end