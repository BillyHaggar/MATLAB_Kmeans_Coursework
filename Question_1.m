%ALL CODE FOR QUESTION 1.
%clear the workspace, close figures and reset for a clean run and reproducability.
clear;
close all;
clc;
rng(0);

%---------------------Question 1 - Data Analysis --------------------------
%--------------------------------------------------------------------------
%Generate the dataset using provided p file and puts into X.
X = gen_kmeansdata(10561789); 

%REPORT N - returns the number of rows of the dataset X into N.
N = size(X,1);

%Calculate the mean of the of the columns in in the dataset X.
columnMeans = mean(X);

%Calculate the standard deviations for the columns in the dataset X.
columnStdDev = std(X);

%Generate a historgram for each of the columns in the dataset X.
for i = 1  : size(X,2)
    figure('name', ['Histigram for Column/Feature - ', num2str(i)],...
        'numbertitle', 'off');
    histogram(X(:,i))
    title(['Histigram for Column/Feature - ' , num2str(i)]);
    xlabel('X - Row Values');
    ylabel('Y - Frequency');
end

%Generate a historgram including all columns
figure('name', 'Histigram for Columns - 1,2,3,4', 'numbertitle', 'off');
xlabel('X - Row Values');
ylabel('Y - Frequency');
title('Histigram for Columns - 1,2,3,4');
hist(X);

%Generate the covarience matrix of the dataset X.
covarienceM = cov(X);

%Generate the correlation matrix of the dataset X.
correlationM = corrcoef(X);

%Plot of the first two features for further data analysis.
figure('name', 'Basic Plot of Features 1 and 2', 'numbertitle', 'off');
title('Basic Plot of Features 1 and 2')
basicPlot = scatter(X(:,1),X(:,2), 'b.');

%----Question 1 - K-means algorithm: find the optimal number of classes----
%--------------------------------------------------------------------------

%Calculate kmeans and plot silhouette representation for K = 3,4 and 5  and find
% mean silhouette.
K = 3;
[idx3,C3,sumd3]=kmeans(X,K);
figure('name', ['Silhouette representation of kmeans when k is: ',...
    num2str(K)], 'numbertitle', 'off');
[silh3,h3] = silhouette(X,idx3,'sqEuclidean');
title(['Silhouette representation of kmeans when k is: ' , num2str(K)]);
xlabel 'Silhouette Value';
ylabel 'K Cluster';
mean_silh3 = mean(silh3);

%Calculate kmeans and plot silhouette representation for K = 4 and find
% mean silhouette.
K = 4;
[idx4,C4,sumd4]=kmeans(X,K);
figure('name', ['Silhouette representation of kmeans when k is: 4'],...
    'numbertitle', 'off');
[silh4,h4] = silhouette(X,idx4,'sqEuclidean');
title(['Silhouette representation of kmeans when k is: ' , num2str(K)]);
xlabel 'Silhouette Value';
ylabel 'K Cluster';
mean_silh4 = mean(silh4);

%Calculate kmeans and plot silhouette representation for K = 5  and find
% mean silhouette.
K = 5;
[idx5,C5,sumd5]=kmeans(X,K);
figure('name', ['Silhouette representation of kmeans when k is: ',...
    num2str(K)], 'numbertitle', 'off');
[silh5,h5] = silhouette(X,idx5,'sqEuclidean');
title(['Silhouette representation of kmeans when k is: ' , num2str(K)]);
xlabel 'Silhouette Value';
ylabel 'K Cluster';
mean_silh5 = mean(silh5);

%BEST

% Plot the clusters and the cluster centroids for k = 3
figure('name', 'Plotted kmeans clusters of X for when k = 3',...
    'numbertitle', 'off');
hold on
plot (X(idx3==1,1),X(idx3==1,2), 'r.','MarkerSize',8)
plot (X(idx3==2,1),X(idx3==2,2),'c.','MarkerSize',8)
plot (X(idx3==3,1),X(idx3==3,2),'g.','MarkerSize',8)
plot(C3(:,1),C3(:,2),'kx','MarkerSize',14,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
    'Location','NW')
  title 'Plotted kmeans clusters of X for when k = 3'

  
% Plot the clusters and the cluster centroids for k = 4
figure('name', 'Plotted kmeans clusters of X for when k = 5',...
    'numbertitle', 'off');
hold on
plot (X(idx4==1,1),X(idx4==1,2), 'r.','MarkerSize',8)
plot (X(idx4==2,1),X(idx4==2,2),'c.','MarkerSize',8)
plot (X(idx4==3,1),X(idx4==3,2),'g.','MarkerSize',8)
plot (X(idx4==4,1),X(idx4==4,2),'y.','MarkerSize',8)
plot(C4(:,1),C4(:,2),'kx','MarkerSize',14,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
        'Location','NW')
  title 'Plotted kmeans clusters of X for when k = 4'

  
% Plot the clusters and the cluster centroids for k = 5
figure('name', 'Plotted kmeans clusters of X for when k = 5',...
    'numbertitle', 'off');
hold on
plot (X(idx5==1,1),X(idx5==1,2), 'r.','MarkerSize',8)
plot (X(idx5==2,1),X(idx5==2,2),'c.','MarkerSize',8)
plot (X(idx5==3,1),X(idx5==3,2),'g.','MarkerSize',8)
plot (X(idx5==4,1),X(idx5==4,2),'y.','MarkerSize',8)
plot (X(idx5==5,1),X(idx5==5,2),'m.','MarkerSize',8)
plot(C5(:,1),C5(:,2),'kx','MarkerSize',14,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5',...
    'Centroids', 'Location','NW')
  title 'Plotted kmeans clusters of X for when k = 5'


%Plot 3D for k = 4 as it is the optimal for K
figure('name', '3D Plotted kmeans clusters of X for when k = 4',...
    'numbertitle', 'off');
hold on
scatter3(X(idx4==1,1),X(idx4==1,2),X(idx4==1,3), 'r.')
scatter3(X(idx4==2,1),X(idx4==2,2),X(idx4==2,3), 'c.')
scatter3(X(idx4==3,1),X(idx4==3,2),X(idx4==3,3), 'g.')
scatter3(X(idx4==4,1),X(idx4==4,2),X(idx4==4,3), 'y.')
scatter3(C4(:,1),C4(:,2),C4(:,3),'kx')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
        'Location','NW')
  title 'Plotted kmeans clusters of dataset X for when k = 4'
hold off
view(2), axis vis3d, box on, rotate3d on
xlabel('x'), ylabel('y'), zlabel('z')



