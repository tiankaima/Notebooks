N=10100;
x=2:N;

for i=2:N
    for j=2:1:floor(sqrt(i))
        if mod(i,j) == 0
            x(i-1) = 0;
            break;
        end
    end
end
x = x(x~=0);

pi_100 = length(x(x<=100));
fprintf('pi(100) = %d\n',pi_100);
pi_1000 = length(x(x<=1000));
fprintf('pi(1000) = %d\n',pi_1000);
pi_10000 = length(x(x<=10000));
fprintf('pi(10000) = %d\n',pi_10000);

pi_100_200 = length(x(x<=200)) - length(x(x<=100));
fprintf('pi(200) - pi(100) = %d\n',pi_100_200);
pi_1000_1100 = length(x(x<=1100)) - length(x(x<=1000));
fprintf('pi(1100) - pi(1000) = %d\n',pi_1000_1100);
pi_10000_10100 = length(x(x<=10100)) - length(x(x<=10000));
fprintf('pi(10100) - pi(10000) = %d\n',pi_10000_10100);