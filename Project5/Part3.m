close all
% Generate 5 random clusters
N = [300, 350, 400, 600, 1000]; % [points per cluster
% Define Cluster centers
mu = zeros(5,2);
mu(1,:) = [0 0];
mu(2,:) = [5 5];
mu(3,:) = [-2 -6];
mu(4,:) = [-6 3];
mu(5,:) = [8 -5];
% Define covariance matrices
Sigma = zeros(2, 2, 5);
Sigma(:,:,1) = [1 0.8; 0.8 1];
Sigma(:,:,2) = [3 0.2; 0.2 3];
Sigma(:,:,3) = [7 0; 0 7];
Sigma(:,:,4) = [1 -0.5; -0.5 5];
Sigma(:,:,5) = [2 -0.8; -0.8 5];

points = []
% Generate 5 distributions
for n = 1:5
    r = mvnrnd(mu(n,:), Sigma(:,:,n), N(n));
    points = [points; r];
end

figure(1)
scatter(points(:,1), points(:,2),1)
title('Original Scatter Plot')
xlabel('x')
ylabel('y')

% K-means Clustering
IDX = kmeans(points,5);

% Plot each cluster with a separate color
colors = ['b', 'g', 'r', 'c', 'm'];
figure(2)
hold on
for n = 1:5
    group = find(IDX == n);
    scatter(points(group, 1), points(group, 2), 3, colors(n))
end
title('Kmeans Clustered Points')
xlabel('x')
ylabel('y')
    
% EM Clustering
gmm = fitgmdist(points,5);
em_idx = cluster(gmm, points);
figure(3)
gscatter(points(:,1), points(:,2), em_idx)
title('EM Clustering')
xlabel('x')
ylabel('y')
