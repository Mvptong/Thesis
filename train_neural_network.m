clear all

%Import the data
data = readmatrix("รวม data clean data.xlsx");
data(:,5) = [];

%Shuffle row data
[m,n] = size(data);
idx = randperm(m);
b = data;
b(idx,:) = data(:,:);

%Find mean value in each variables
mean1 = mean(data(:,1));
mean2 = mean(data(:,2));
mean3 = mean(data(:,3));
mean4 = mean(data(:,4));
mean5 = mean(data(:,5));
mean6 = mean(data(:,6));
meanvalue = [mean1 mean2 mean3 mean4 mean5 mean6];

%Find std value in each variables
std1 = std(data(:,1));
std2 = std(data(:,2));
std3 = std(data(:,3));
std4 = std(data(:,4));
std5 = std(data(:,5));
std6 = std(data(:,6));
stdvalue = [std1 std2 std3 std4 std5 std6];

%Prepare data before train Neural Network
datastandardize = (b-meanvalue)./stdvalue;

%organize data before train NN
input = datastandardize(1:10000,1:5);
output = datastandardize(1:10000,6);
input = input';
output = output';

%Optimize the numbers of neurons in the hidden layer
    
for  i = 1:10
     
    %defining the architechture of ANN
    net = fitnet([i]);
    net.divideParam.trainRatio = 40/100;
    net.divideParam.valRatio = 30/100;
    net.divideParam.testRatio = 30/100;
    
    %training ANN
    [net,tr] = train(net,input,output);
       
    
    %determine the error of ANN
    yTrain = net(input(:,tr.trainInd));
    yTrain = (yTrain.*std6)+mean6; 
    yTrain = yTrain';
    yTrue = b(tr.trainInd,6);
    RMSEtrain_(i) = sqrt(mean((yTrain-yTrue).^2)); %RMSE train
    yVal = net(input(:,tr.valInd));
    yVal = (yVal.*std6)+mean6;
    yVal = yVal';
    yTrueVal = b(tr.valInd,6);
    RMSEval_(i) = sqrt(mean((yVal-yTrueVal).^2)); % RMSE Validation
    
    %determine the error of ANN 
    inputtest = datastandardize(10001:299500,1:5);
    inputtest = inputtest';
    outputtest = b(10001:299500,6);
    outputpredict = net(inputtest);
    outputpredict = (outputpredict.*std6)+mean6;
    outputpredict = outputpredict';
    RMSE_(i) = sqrt(mean((outputpredict-outputtest).^2)); %RMSE train
    Rsq_(i) = 1 - sum((outputtest - outputpredict).^2)/sum((outputtest - mean(outputtest)).^2);
    end

