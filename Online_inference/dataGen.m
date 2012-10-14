function [X y] = dataGen(numSamples,numGaussians,numDimensions) 
%% Generates a Mixture of Gaussians dataset

%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

	X = []; 
	y = [];
	seed = 0;
	rand('seed',seed);
	randn('seed',seed);
	%% theta - the probability for different gaussians sampled from Dirichlet
	theta = drchrnd(ones(1,numGaussians) * 20,1);

	%% each row vector is the mean for different gaussians
	sigmaScaleFactor = 160;
	muScaleFactor = sqrt(12*numGaussians);

	mu = randn(numGaussians,numDimensions) * muScaleFactor;

	Sigma = zeros(numDimensions, numDimensions, numGaussians);
	R = zeros(numDimensions, numDimensions, numGaussians);       
	
	sigmaModel = struct();
	sigmaModel.Sigma = eye(numDimensions)*sigmaScaleFactor;
	sigmaModel.dof = 15;
	Sigma = invWishartSample(sigmaModel,numGaussians);
	numPerGaussian = mnrnd(numSamples,theta);

	for i=1:numGaussians
		R(:,:,i) = chol(Sigma(:,:,i));
		Xi = repmat(mu(i,:),numPerGaussian(i),1) + randn(numPerGaussian(i),numDimensions)*R(:,:,i);
		X = [ X; Xi ];
		y = [ y; i*ones(numPerGaussian(i),1) ];
	end

	perm = randperm(numSamples);
	X = X(perm,:);
	y = y(perm);
end
