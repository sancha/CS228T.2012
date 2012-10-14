function params = lda_estep_fn(X,alpha,beta,V,K,M,N,m)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Maximizes the energy functional with respect to 
% variational parameters `phi` and `gamma` of the
% m-th document in the dataset.
%
% X:		cell array where each cell contains a document
%			Each document is represented as a vector of word indices
% alpha:	(1 x K) Current setting of the alpha hyperparmeter
% beta:	(K x V) Current setting of the beta parameter
% V:		Size of the vocabulary
% K:		Number of topics we expect the dataset contains.
% M:		Number of documents in the dataset
% N:		Count of words in all documents
% m:		Index of the document of interest

	gamma_tol = 1e-1;
	phi_tol = 1e-1;

	gamma = alpha + N(m) / K;
	phi = ones(N(m),K) / K;
	X = X{m};

	%% (2) INSERT CODE HERE

	assert(~any(isnan(phi(:))));
	assert(~any(isinf(phi(:))));
	assert(~any(phi(:)<=0));

	params.phi = phi;
	params.gamma = gamma;
end


