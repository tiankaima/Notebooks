count=0;
total=100000000;
for i=1:total
    x=rand();
    y=rand();
    z=rand();
    if x^2+y^2<=1 & x^2+z^2<=1 & y^2+z^2<=1
        count=count+1;
    end
end

fprintf('Volume of body: %.20f\n', count/total);