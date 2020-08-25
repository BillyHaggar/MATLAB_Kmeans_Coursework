%ALL CODE FOR QUESTION 2
%clear the workspace, close figures and reset for a clean run and reproducability.
clear;
close all;
clc;
rng(0);

%---------------------Question 2 - Data Analysis --------------------------
%--------------------------------------------------------------------------
%Generate the dataset using provided p file and puts into Y.
Y = gen_superdata(10561789);

%REPORT N - returns the number of rows of the dataset Y into N.
N = size(Y,1);

%Create the dataset from features 1 to 5 to rid the class
%label column and put labels in a seperate matrix
dataset = Y(:,1:5);
class_Labels = Y(:,6:6);

%Calculate the mean of the of the columns in in the dataset Y.
columnMeans = mean(dataset,1);

%Calculate the standard deviations for the columns in the dataset Y.
columnStdDev = std(dataset);

%Generate the covarience matrix of the dataset Y.
covarienceM = cov(dataset);

%Generate the correlation matrix of the dataset Y.
correlationM = corrcoef(dataset);

%Report the number of Classes
num_Classes = max(class_Labels);

%Plot the first two features two visualise the dataset.
figure('name', 'Basic Plot of Features 1 and 2', 'numbertitle', 'off');
basicPlot = scatter(Y(:,1),Y(:,2), 'b.');


%DATA PRE-PROCESSING-------------------------------------------------------
%Data preprocessing, randomally selecting 60% of rows/data
Training_Size = N*0.6; %set the training set size to 60% of samples
assert(Training_Size<=N); %training set cannot be more than 100% of samples
Rand_Row_Index = randperm(N); % Shuffle the dataset by shuffling the index of rows


m = 1; %counter for how many samples are allocated
j = 1; % counter for how many samples are in the testing set

for i=1:size(Y,1)
         if m <= Training_Size % allocates rows to training until 60% is allocated
                Training_Temp{i}=Y(Rand_Row_Index(i),:); %uses the shuffled dataset index to get a random row from original dataset
                m=m+1; 
         else                                           %allocate the rest of rows to testing
                 Testing_Temp{j}=Y(Rand_Row_Index(i),:); %using the shuffled dataset  
                 m=m+1;
                 j=j+1;
         end
end

%Test the dataset for K = 5 and K = 7

%move the training set into a better table format, same for testing
Training_Dataset_Labeled = cell2mat(Training_Temp');
Testing_Dataset_Labeled = cell2mat(Testing_Temp');   
  
%testing_dataset without class labels;
Testing_Dataset = Testing_Dataset_Labeled(:,1:5);
%training_dataset without class labels;
Training_Dataset = Training_Dataset_Labeled(:,1:5);
%the seperate labels for testing and training dataset;
Class_Lab_Training = Training_Dataset_Labeled(:,6:6);
Class_Lab_Testing = Testing_Dataset_Labeled(:,6:6);


%KNN CLASSIFIER------------------------------------------------------------
%K = 5 and 7 Training and Testing 
 for c = 1:2 %Repeat twice for K = 5 and K = 7  
    %as we k as 5 and 7, this set k to 5 on the first iteration and 7 on
    %the second will be 5 + 2 (7)
    K = 5 + (2 * (c-1));
    %Generate the model for KNN with the training data, this will be used
    %for the testing data to see if data is classified correctly
    Mdl = fitcknn(Training_Dataset,Class_Lab_Training,'NumNeighbors',K); 
 
        %Generates the labels for the test data 
        for i = 1:size(Testing_Dataset, 1)
            Testing_Example = Testing_Dataset(i,:); %iteratate through testing dataset one by one
            %and generate the class label for each one by using the trained
            %model from the training data
            Pred_KNN_Label(i) = predict(Mdl,Testing_Example);
        end
 
  
 %Confusion matrix for testing data
        for i=1:num_Classes
            %What ever i is equal to this will contain all indexes for that
            %class of what that should have been originally
             Current_Class_Indexes=find(Class_Lab_Testing==i);
             %num_Datapoint is the number of data points that classified as
             %the current class being calculated for the confusion matrix
             num_Datapoints=length(Current_Class_Indexes);
  
              for j=1:num_Classes
                  %Correct classifications for each class, how may calculated
                  %class labels match the original.
                  Classification=length(find(Pred_KNN_Label(Current_Class_Indexes)==j));
                  %Calculate the percentage correct classifications for the
                  %confusion matrix
                  Confusion_Matrix(j,i)=Classification/num_Datapoints*100;
              end
        end
 
    disp(['When K = ' , num2str(K), ' (The confusion matrix is below)']);
    display (Confusion_Matrix,'KNN:confusion matrix for testing data');

   
   %Find the average of correct classifications from the training set
    Average_Correct_Classification = length(find((Pred_KNN_Label-Class_Lab_Testing')==0))/length(Class_Lab_Testing)*100;
    disp(['KNN: Percentage of correct classifications for testing data: ',...
        num2str(Average_Correct_Classification), '%']);
    
    disp('');
    disp('____________________________________________________');
 end
 
%Extras like plotting the classifications
%plot KNN when K = 7 
figure('name', 'Plot of data seperated by classes: classes then split by training and testing',...
    'numbertitle', 'off');
title('Plot of data seperated by classes: classes then split by training and testing');
hold on;
%compare the testing and training for class 1
plot(Training_Dataset(Class_Lab_Training==1,1),Training_Dataset(Class_Lab_Training==1,2),'b.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==1,1),Testing_Dataset(Class_Lab_Testing==1,2),'bx', 'MarkerSize',8)
%compare the testing and training for class 2
plot(Training_Dataset(Class_Lab_Training==2,1),Training_Dataset(Class_Lab_Training==2,2),'r.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==2,1),Testing_Dataset(Class_Lab_Testing==2,2),'rx', 'MarkerSize',8)
%compare the testing and training for class 3
plot(Training_Dataset(Class_Lab_Training==3,1),Training_Dataset(Class_Lab_Training==3,2),'g.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==3,1),Testing_Dataset(Class_Lab_Testing==3,2),'gx', 'MarkerSize',8)
%compare the testing and training for class 4
plot(Training_Dataset(Class_Lab_Training==4,1),Training_Dataset(Class_Lab_Training==4,2),'m.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==4,1),Testing_Dataset(Class_Lab_Testing==4,2),'mx', 'MarkerSize',8)
%compare the testing and training for class 5
plot(Training_Dataset(Class_Lab_Training==5,1),Training_Dataset(Class_Lab_Training==5,2),'c.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==5,1),Testing_Dataset(Class_Lab_Testing==5,2),'cx', 'MarkerSize',8)
%compare the testing and training for class 6
plot(Training_Dataset(Class_Lab_Training==6,1),Training_Dataset(Class_Lab_Training==6,2),'k.', 'MarkerSize',8)
plot(Testing_Dataset(Class_Lab_Testing==6,1),Testing_Dataset(Class_Lab_Testing==6,2),'kx', 'MarkerSize',8)
legend('Class 1 - Training','Class 1 - Testing', ...
    'Class 2 - Training','Class 2 - Testing', ...
    'Class 3 - Training','Class 3 - Testing', ...
    'Class 4 - Training','Class 4 - Testing', ...
    'Class 5 - Training','Class 5 - Testing', ...
    'Class 6 - Training','Class 6 - Testing', 'Location','NW');
    hold off;