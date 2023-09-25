% goal: plot mobious strip.

% details:
%
% 1. in 3d, draw x^2 + y^2 = 1 as the base.
% 2. for every t in [0,2pi) corresponding to the point (cos(t), sin(t)),
% 3. draw a line that have slope (=t, in radian) and pass through the point, with a length of 2.
% 4. now, split t into 2pi/1000, and repeat 2-3.
% 5. create image for every t, and save it as a gif.

line_length=0.2;
image_count=100;

for i=1:image_count
    step = 2*pi/image_count;
    t_end = i * step;

    % circle
    t=0:0.01:2*pi;
    x=cos(t);
    y=sin(t);
    z=zeros(size(t));
    plot3(x,y,z,'k','LineWidth',2);
    hold on;

    % lines
    for t=0:0.05:t_end
        x=[cos(t)*(1-line_length*sin(t/2)), cos(t)*(1+line_length*sin(t/2))];
        y=[sin(t)*(1-line_length*sin(t/2)), sin(t)*(1+line_length*sin(t/2))];
        z=[-line_length*cos(t/2), line_length*cos(t/2)];
        plot3(x,y,z,'k','LineWidth',2);
    end

    % plotting:
    grid on;
    daspect([1 1 1])
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
      imwrite(imind,cm,'math-expt/week_3/imgs/Q6_1.gif','gif', 'Loopcount',inf);
    else
      imwrite(imind,cm,'math-expt/week_3/imgs/Q6_1.gif','gif','WriteMode','append');
    end
end
