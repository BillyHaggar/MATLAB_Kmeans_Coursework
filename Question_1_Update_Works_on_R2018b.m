%ALL CODE FOR QUESTION 1 RUNS ON >R2017A.
%clear the workspace, close figures and reset for a clean run.
clear;
close all;
clc;
rng(0);

colours = ["r." "c." "g." "y." "m." "k" "kx"];
c = 1; % colour counter

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
    figure('name', ['Histigram for Feature - ', num2str(i)],...
        'numbertitle', 'off');
    histogram(X(:,i))
    title(['Column - ' , num2str(i)]);
    xlabel('X - Row Values');
    ylabel('Y - Frequency');
end

%Generate a historgram including all columns
figure('name', 'Histigram for Features - 1,2,3,4', 'numbertitle', 'off');
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

%Calculate kmeans and plot silhouette representation for K=  3, 4 & 5 and find
% mean silhouette. Then plot the graphs.
for K = 3 : 5
    [idx,C,sumd]=kmeans(X,K);
    figure('name', ['Silhouette representation of kmeans when k is: ',...
    num2str(K)], 'numbertitle', 'off');
    [silh,h] = silhouette(X,idx,'sqEuclidean');
    title(['Silhouette representation of kmeans when k is: ' , num2str(K)]);
    xlabel 'Silhouette Value';
    ylabel 'K Cluster';
    mean_silh = mean(silh);
    disp(['Mean silhouette value for when K = ', num2str(K) ,...
      ': ', num2str(mean_silh)])
  
  figure('name', ['Plotted kmeans clusters of X for when k = ' , num2str(K)],...
    'numbertitle', 'off');
  hold on
  c = 1;
  for i = 1 : K
     plot (X(idx==i,1),X(idx==i,2), colours(c),'MarkerSize',8)
     if (c < 6)
        c = c + 1;
    end 
  end
     plot(C(:,1),C(:,2),'kx','MarkerSize',14,'LineWidth',2)
    legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
    'Location','NW');
    title (['Plotted kmeans clusters of X for when k = ', num2str(K)])
  
  if (K == 4)%Plot 3d for k = 4 as it is the optimal for K
    figure('name', '3D Plotted kmeans clusters of X for when k = 5',...
    'numbertitle', 'off');
    hold on 
    c = 1;
    for i = 1 : K
    scatter3(X(idx==i,1),X(idx==i,2),X(idx==i,3), colours(c))
    if (c < 6)
        c = c + 1;
    end  
    end 
    scatter3(C(:,1),C(:,2),C(:,3),'kx')
    legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
        'Location','NW')
    title 'Plotted kmeans clusters of dataset X for when k = 4'
    hold off
    view(2), axis vis3d, box on, rotate3d on
    xlabel('x'), ylabel('y'), zlabel('z')
      
  end    
end









