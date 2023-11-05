% load data
P = load('data/p1_swanPolygon.txt');
x = P(:,1);
y = P(:,2);

pgon = polyshape(x,y); % mainly for drawing

pts = poissonDisc([100,100],2); % random points(possion disc method)
inside = isinterior(pgon, pts(:, 1), pts(:, 2));
pts = pts(inside,:); % filter
pts = [P;pts]; % combined

n = length(P);
C = [(1:n)' circshift((1:n)',-1)]; % limit delaunany Trigangulation inside the polygon

DT = delaunayTriangulation(pts,C);
IO = isInterior(DT);
kDT = DT.ConnectivityList(IO,:);
n = size(kDT,1);

centroid_list = zeros(n,2); % (n,2)
area_list = zeros(n,1); % (n,1)

for i = 1:size(DT.ConnectivityList(IO,:),1)
    % Get the vertices of the triangle
    v1 = DT.Points(kDT(i,1),:);
    v2 = DT.Points(kDT(i,2),:);
    v3 = DT.Points(kDT(i,3),:);
    
    % Calculate and store the centroid
    centroid_list(i,:) = (v1 + v2 + v3)/3;
    
    % Calculate and store the area
    area_list(i) = abs((v1(1)*(v2(2)-v3(2)) + v2(1)*(v3(2)-v1(2)) + v3(1)*(v1(2)-v2(2)))/2);
end

total_area = sum(area_list,1)
weighted_center = sum(centroid_list .* area_list,1) / total_area

under_water_part = find(centroid_list(:,2)<20);
under_water_area = sum(area_list(under_water_part,:),1)
tmp=(centroid_list .* area_list);
under_water_weighted_center = sum(tmp(under_water_part,:),1) / under_water_area

density = under_water_area / (1.25 * total_area) % however this is still not stable since they don't have same axis.

x = zeros(n);
% limit: x > 0 && x < 1 -> x > 0.1 && x < 0.9
% (x .* centroid_list .* area_list)/sum(x .* area_list) == under_water_weighted_center
% x .* centroid_list .* area_list = under_water_weighted_center * under_water_area / 1.25
% sum(x .* area_list) * 1.25 == under_water_area
f = zeros(n, 1);

% Inequalities
% lower bound, -x <= -0.1, upper bound x <= 0.9
lb = 0.1 * ones(n, 1);
ub = 0.9 * ones(n, 1);
A = [];
b = [];

% Equalities
% tmp = centroid_list .* area_list;
% Aeq = horzcat(tmp(:,1),tmp(:,2),area_list);
% Aeq = transpose(Aeq);
% tmp = under_water_weighted_center .* under_water_area ./ 1.25;
% beq = [tmp(1),tmp(2),under_water_area / 1.25];
% beq = transpose(beq);


tmp = centroid_list(:,1) .* area_list;
Aeq = horzcat(tmp,area_list);
Aeq = transpose(Aeq);
tmp = under_water_weighted_center .* under_water_area ./ 1.25;
beq = [tmp(1),under_water_area / 1.25];
beq = transpose(beq);

% Aeq = horzcat(area_list)
% Aeq = transpose(Aeq);
% beq = [under_water_area / 1.25]
% beq = transpose(beq);

% size(Aeq);
% Aeq(1,:);
% beq(1,:);

% centroid_list(1,:);
% area_list(1,:);

% let's solve the problem
opts = optimoptions('linprog','Algorithm','interior-point');
[x, fval] = linprog(f, A, b, Aeq, beq, lb, ub, opts);



new_center = sum(x .* centroid_list .* area_list, 1) / sum(x .* area_list, 1)



% plotting methods:
plot(pgon)
hold on

triplot(DT(IO,:),DT.Points(:,1),DT.Points(:,2),'LineWidth',2)
text(weighted_center(1), weighted_center(2), 'center', 'FontSize',20);
text(under_water_weighted_center(1), under_water_weighted_center(2), 'underwater center', 'FontSize',20);
text(new_center(1), new_center(2), 'new center', 'FontSize',20);
scatter(centroid_list(:,1),centroid_list(:,2),'r.')

%for i = 1:size(centroid_list,1)
%    text(centroid_list(i,1), centroid_list(i,2), num2str(x(i)), 'FontSize',8);
%end


% scatter(centroid_list(:,1),centroid_list(:,2),'r.')
% for i = 1:size(centroid_list,1)
%    text(centroid_list(i,1), centroid_list(i,2), num2str(area_list(i)), 'FontSize',8);
% end
axis equal
hold off
