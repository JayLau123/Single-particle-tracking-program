
%% 
clear all
clc

%% II. Set the dataset
%%
% 1. Import the data
load lastparent.x.mat;
load lastparent.objcost.mat;

%%
% 2. Produce the training dataset and test dataset
temp = randperm(size(lastparent.x,1));
% training set: 15300 samples
P_train =lastparent.x(temp(1:15300),:)';
T_train = lastparent.objcost(temp(1:15300),:)';
% test set: 189 samples
P_test = lastparent.x(temp(15301:end),:)';
T_test = lastparent.objcost(temp(15301:end),:)';
N = size(P_test,2);


%% III. normalization
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);

[t_train, ps_output] = mapminmax(T_train,0,1);
%%


%% IV. BP neural network 
%%
% 1. Create the neural network
    net = newff(p_train,t_train,10);
%%
% 2. Set parameters
net.trainParam.epochs = 1000;% iteration times
net.trainParam.goal = 1e-4;% end after reach the goal of MSE<1e-4
net.trainParam.lr = 0.001;% set a smaller learn rate to improve accuracy, but slow down the convergence
net.trainParam.max_fail =10; %validation checks
%%
% 3. Start training 
net = train(net,p_train,t_train);

%%
% 4. Simulation test
t_sim = sim(net,p_test);

%%
% 5. Inverse normalization
T_sim = mapminmax('reverse',t_sim,ps_output);

%% V. Evaluation
%%
% 1. Average relative error
error1 = abs(T_sim(1,:) - T_test(1,:))./T_test(1,:);
error2 = abs(T_sim(2,:) - T_test(2,:))./T_test(2,:);
mse1 = mean(error1) 
mse2 = mean(error2)
%%
% 2. Coefficient of determination R^2
R21 = (N * sum(T_sim(1,:) .* T_test(1,:)) - sum(T_sim(1,:)) * sum(T_test(1,:)))^2 / ((N * sum((T_sim(1,:)).^2) - (sum(T_sim(1,:)))^2) * (N * sum((T_test(1,:)).^2) - (sum(T_test(1,:)))^2)); 
R22 = (N * sum(T_sim(2,:) .* T_test(2,:)) - sum(T_sim(2,:)) * sum(T_test(2,:)))^2 / ((N * sum((T_sim(2,:)).^2) - (sum(T_sim(2,:)))^2) * (N * sum((T_test(2,:)).^2) - (sum(T_test(2,:)))^2)); 

%%
% % 3. Result analysis
result1 = [T_test(1,:)' T_sim(1,:)' error1'];
result2 = [T_test(2,:)' T_sim(2,:)' error2'];

%% VI. Plot
figure
plot(1:N,T_test(1,:),'b:*',1:N,T_sim(1,:),'r-o')
legend('True value','Predicted value')
xlabel('Samples')
ylabel('lastparent.objcost')
string = {'Result analysis';['R^2=' num2str(R21)]};
title(string)
set(gca,'XLim',[0,200]);
grid on
figure
plot(1:N,T_test(2,:),'b:*',1:N,T_sim(2,:),'r-o')
legend('True value','Predicted value')
xlabel('Samples')
ylabel('lastparent.objcost')
string = {'Result analysis';['R^2=' num2str(R22)]};
title(string)
set(gca,'XLim',[0,200]);
grid on;
