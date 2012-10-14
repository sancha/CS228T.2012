function	[model z] = onlineEM(X,numGaussians,blockSize,alpha,m0,kappa0,nu0,S0);
%% Online EM for Gaussian Mixture models. Use the batch stepwise framework from 
%% Liang09, except with the MAP updates as in the slides for lecture 3.

%% Inputs:
%% X : (numSamples x numDimensions)
%% numGaussians  
%% blockSize 
%%
%% alpha : hyperparameter for the symmetric Dirichlet prior (1 x numGaussians)
%% m0 : hyperparameter for the mean of all the mu (numDimensions x 1) 
%% kappa0 : hyperparameter for the precision of all the mu (1 x 1)
%% nu0 : hyperparameter for the precision of all the Sigma (1 x 1) 
%% S0 : hyperparameter that is proportional to the mean of all the Sigma 
%%			(numDimensions x numDimensions)  
%%
%% Outputs:
%% model is a struct containing: 
%% i. phi (1 x numGaussians) 
%% ii. mu (numGaussians x numDimensions)
%% iii. Sigma (numDimensions x numDimensions x numGaussians)
%% 
%% z is the vector of labels for all data items.

%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

	seed = 1;
	rand('seed',seed);
	randn('seed',seed);
	figure; 

	fullX = X;
	[numSamples numDimensions] = size(fullX);
	blocks = blockify(fullX,blockSize);
	numBlocks = numel(blocks);
	numEpochs = 1;

	model = struct();
	T = numBlocks*numEpochs;

	%% step-sizes
	beta = 0.55; 
	eta = ([1:T]+2) .^ (-beta);

	%% Initialization 
	%% (1/4) INSERT CODE HERE

	for t=1:T
		i = mod(t-1,numBlocks)+1; 
		X = blocks{i};
		blockSize = size(X,1);

		%% This is all the data we have seen so far
		plotModel(fullX(1:min(t*blockSize,numSamples),:),model,t);
		mov(t) = getframe;
	
		%% E-step		
		%% Compute the expected sufficient statistics of this block
		%% (2/4) INSERT CODE HERE

		%% M-step
		%% Update the model parameters as in the description of
		%% stepwise EM in Liang09, but with MAP instead of MLE.
		%% Refer to slides from lecture 3 for the formulae
		%% (3/4) INSERT CODE HERE

	end
	movie(mov,1);

	%% Calculate and return z 
	%% z(i) is the predicted label for the ith instance. 
	%% (4/4) INSERT CODE HERE
end

function mu = initializeMus(X,numGaussians)
%% Initializes the means by sampling several sets of numGaussian 
%% points from the first batch, and picking the set of points which
%% maximizes the sum of the pairwise distances
	[numSamples numDimensions] = size(X);
	numSets = numSamples * 20;
	randPicks = ceil(rand(numSets,numGaussians) * numSamples);
	for i=1:numSets
		distances(i) = sum(pdist(X(randPicks(i,:),:)));
	end
	[val ind] = max(distances);
	mu = X(randPicks(ind,:),:);
end

function blocks = blockify(X,blockSize)
	blocks = {};
	[numSamples numDimensions] = size(X);
	numBlocks = ceil(numSamples/blockSize);
	for i=1:numBlocks
		startPos = (i-1)*blockSize+1;
		endPos = min(numSamples,i*blockSize);
		blocks{i} = X(startPos:endPos,:);
	end
end

function plotModel(X,gmmModel,itrNumber)
	fprintf ('.');
	numGaussians = numel(gmmModel.phi);
	[numSamples numDimensions] = size(X);
	Q = zeros(numSamples, numGaussians);
	for i=1:numSamples
		Q(i,:) = gmmModel.phi .* mvnpdf(repmat(X(i,:),numGaussians,1), gmmModel.mu, gmmModel.Sigma)';
		Q(i,:) = Q(i,:)/sum(Q(i,:));
	end

	[maxQ maxI] = max(Q');	
	plotData (numGaussians,X,maxI,sprintf('Online EM : %d',itrNumber),true);
	scatter(gmmModel.mu(:,1),gmmModel.mu(:,2),'ko','filled');
	for s=1:numGaussians
		confidenceEllipse(gmmModel.Sigma(:,:,s),gmmModel.mu(s,:),'style','k-');
	end
end

