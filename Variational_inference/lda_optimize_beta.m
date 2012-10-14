function beta = lda_optimize_beta(X,phi,gamma,alpha,K,V,M)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Maximizes the energy functional with respect to beta
%
% X:		cell array where each cell contains a document
%			Each document is represented as a vector of word indices
% alpha:	(1 x K) Current setting of the alpha hyperparmeter
% phi:	(M x 1) cell array, each of size (N x K), N is the
%			number of words in the doc. Variational multinomial parameter
% gamma: (M x K) is the variational Dirichlet parameter
% V:		Size of the vocabulary
% K:		Number of topics we expect the dataset contains.
% M:		Number of documents in the dataset

	%% (3) INSERT CODE HERE
	
	assert(~any(beta(:)<=0));
	fval = energy_functional(X,phi,gamma,alpha,beta);
	%% Make you see an improvement in energy functional 
	%% after updating the beta.
	fprintf('BETA \t %7.5f\n',fval); 	
end

