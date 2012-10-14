function P = collapsedGibbs(X,numGaussians,alpha,m0,kappa0,S0,nu0)
%% Collapsed Gibbs for the Gaussian Mixture Model
%% Inputs:
%% alpha : hyperparameter for the symmetric Dirichlet prior (1 x 1)
%% m0 : hyperparameter for the mean of all the mu (numDimensions x 1) 
%% kappa0 : hyperparameter for the precision of all the mu (1 x 1)
%% S0 : hyperparameter that is proportional to the mean of all the Sigma 
%%			(numDimensions x numDimensions)  
%% nu0 : hyperparameter for the precision of all the Sigma (1 x 1) 
%% 
%% Outputs:
%% P : Pairwise probabilities for being in the same cluster.

%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

seed = 0;
rand('seed',seed);
randn('seed',seed);
figure; 

[numSamples numDimensions] = size(X);
P = sparse(numSamples, numSamples);
[R C] = meshgrid(1:numSamples);
T = 50;
burnIn = 20;

%% Initialization %%
%% z has to be a vector of labels (numSamples x 1)
%% (1/3) INSERT CODE HERE

for t=1:T
	fprintf('.');
	plotData (numGaussians,X,z,sprintf('Collapsed Gibbs %d',t),true);	
	mov(t) = getframe;
	drawnow expose;

	%% Collapsed-Gibbs phase %%
	%% (2/3) INSERT CODE HERE

	if t>burnIn
		P = P + sparse(z(R) == z(C));
	end
end
P = bsxfun(@rdivide, P, T-burnIn);

%% Plotting the mean of mean posterior %%
for s=1:numGaussians		
	%% (3/3) INSERT CODE HERE %%
	%% Calculate the posterior hyperparameters SN 
	%% (numDimensions x numDimensions) and mN (numDimensions x 1)
	%% corresponding to the s-th cluster.
	
	hold on; 
	confidenceEllipse(SN,mN,'style','k.');
	scatter(mN(1),mN(2),'ko','filled');
end

movie(mov,1);
