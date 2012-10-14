%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Read startup.m for startup instructions 
%% IMPORTANT : You may need to modify the pointer to your installation of pmtk
fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 1\n\n');

load spamassassins.mat;

A=A';
[m n] = size(A);
lambda = 1e-3;

test_set = 3001:m; 
A_test = A(test_set,:);
y_test = y(test_set);

pos_test_y = find(y_test==1);
neg_test_y = find(y_test==0);

y_test_roc = [1-y_test y_test]';

do_adf = false;
do_stoch = false;
do_online_em = true;
do_adf_full = false;
train_size= 3000

%%% SGD 
if do_stoch
	options = struct();
	%% INSERT CODE HERE
	%% You are welcome to try different paramters like
	%% step size (function), mini batch sizes, number of epochs
	%% and perform cross validation if you need to, to pass
	%% this test, please fill in the final params here
	%% before submitting the code.
	fprintf ('Stochgrad Train size : %d\n', train_size);
	A_train = A(1:train_size,:);
	y_train = y(1:train_size);
	w = SGD(zeros(n,1), options, A_train, y_train, lambda);
	stoch_py = sigmoid(A_test*w);
	stoch_py_roc = [1-stoch_py stoch_py]';
	
	stoch_cm = confusionmat(y_test,double(int32(stoch_py)))
	acc = sum(diag(stoch_cm))/sum(sum(stoch_cm))
	printTestResults(acc, 0.86, 'SGD')
	plotroc(y_test_roc, stoch_py_roc);
end


%%% ADF 
if do_adf 
	fprintf('ADF: Train size %d\n', train_size);
	A_train = A(1:train_size,:);
	y_train = y(1:train_size);

	[w_tMean w_tVariance] = ADF(A_train,y_train,lambda);
	adf_py = sigmoid(A_test*w_tMean);
	adf_py_roc = [1-adf_py adf_py]';
	
	adf_cm = confusionmat(y_test,double(int32(adf_py)))
	acc = sum(diag(adf_cm))/sum(sum(adf_cm))

	figure; 	
	plotroc(y_test_roc, adf_py_roc);
	hold on;
	title (sprintf('ADF ROC %d', train_size));
	hold off;
	printTestResults(acc, 0.96, 'ADF');
end

%% OPTIONAL %%
if do_adf_full
   fprintf ('Training on all data ...\n');
	[w_tMean w_tVariance] = ADF(A,y,lambda);
	adf_py = sigmoid(A*w_tMean) >= 0.5;
	adf_cm = confusionmat(y,double(int32(adf_py)))
	acc = sum(diag(adf_cm))/sum(sum(adf_cm))
	printTestResults(acc, 0.995, 'ADF');
end


numSamples = 3000;
numGaussians = 4;
numDimensions = 2;

[X y] = dataGen(numSamples,numGaussians,numDimensions); 
plotData (numGaussians,X,y,'Ground truth');

maxError = 0.3;

if do_online_em
	alpha = ones(1,numGaussians)*10;
	m0 = zeros(numDimensions,1);
	kappa0 = 0;
	S0 = eye(numDimensions,numDimensions) * 100;
	nu0 = 20;
	blockSize = 100;
	[model z] = onlineEM(X,numGaussians,blockSize,alpha,m0,kappa0,nu0,S0);
	%% Plot results
	plotData(numGaussians,X,z,'Online EM Results');
	hold on; 
	scatter(model.mu(:,1),model.mu(:,2),'ko','filled');
	for s=1:numGaussians
		confidenceEllipse(model.Sigma(:,:,s),model.mu(s,:),'style','k-');
	end

	confmat = confusionmat(z,y);
	[bsNrmError bsRndError] = evaluateClustering(X,y,z);
	printTestResults(bsNrmError, maxError, 'Online EM');
	confmat
end
