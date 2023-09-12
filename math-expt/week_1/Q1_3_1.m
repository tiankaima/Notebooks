range=3:7;
lower_sums=[];
upper_sums=[];

for m=range
    n=10^m;
    lower_sum = 0;
    upper_sum = 0;

    for k=0:n-1
        lower_sum = lower_sum + (1/(n+k+1));
        upper_sum = upper_sum + (1/(n+k));
    end

    average = (lower_sum + upper_sum)/2;
    fprintf('n = %d\n', n);
    error = abs(average - log(2));
    fprintf('lower_sum = %f, upper_sum = %f\n', lower_sum, upper_sum);
    fprintf('average = %f\n', average);
    fprintf('error = %f\n\n', error);
    lower_sums = [lower_sums, lower_sum];
    upper_sums = [upper_sums, upper_sum];
end

subplot(1,1,1)

plot(range, upper_sums);
hold on;
plot(range, lower_sums);
plot(range, zeros(length(range),1) + log(2));
hold off;