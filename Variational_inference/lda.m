function [alpha beta fval] = lda(X,V,K)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Implements variational inference for Latent Dirichlet Allocation
%
% X:	cell array where each cell contains a document
%		Each document is represented as a vector of word indices
% V:	Size of the vocabulary
% K:	Number of topics we expect the dataset contains.
% 
%
%% The variables are named as in the problem description:
%
% alpha:	(1 x K) the Dirichlet prior over theta
% beta:	(K x V) `beta(i,:)` specifies the multinomial distribution 
%			over words for the topic `i`
% phi:	(M x 1) cell array, each of size (N x K), N is the
%			number of words in the doc. Variational multinomial parameter
% gamma: (M x K) is the variational Dirichlet parameter

% ****You will NOT need to change any code in this file****

	rand('seed',0);
	tol = 1e-1;
	max_iters = 30;
	fval = -Inf;

	% Number of documents in the dataset
	M = size(X,1); 
	alpha = ones(1,K)/K;
	% initialize randomly for breaking symmetry
	beta = normalize_rows(rand(K,V));
	% Count of words in each document
	N = cellfun(@(x) length(x), X);
	
	fprintf('ITER \t FVAL \n');
	for iter=1:max_iters
		prev_fval = fval;
		
		%% E-step
		[phi gamma] = lda_estep(X,alpha,beta,V,K,M,N);
		fval = energy_functional(X,phi,gamma,alpha,beta);
		fprintf('%2d E \t %7.5f\n',iter,fval);
		
		%% M-step
		[alpha beta] = lda_mstep(X,phi,gamma,alpha,K,V,M);
		fval = energy_functional(X,phi,gamma,alpha,beta);
		fprintf('%2d M \t %7.5f\n',iter,fval);

		if fval-prev_fval < tol
			break;
		end
	end
end

function [phi gamma] = lda_estep(X,alpha,beta,V,K,M,N)
% Do not change this code. Fill in `lda_estep_fn.m` instead
% to optimize phi and gamma with respect to a single document 
% as you derived in the exercise

	params = arrayfun(@(m) lda_estep_fn(X,alpha,beta,V,K,M,N,m),colvec(1:M));
	phi = arrayfun(@(s) s.phi, params, 'UniformOutput', false);
	gamma = cell2mat(arrayfun(@(s) s.gamma, params, 'UniformOutput', false));
	assert(~any(isnan(gamma(:))));
	assert(~any(isinf(gamma(:))));
end


function [alpha beta] = lda_mstep(X,phi,gamma,alpha,K,V,M)
% Do not change this code. Fill in `lda_optimize_beta.m` instead
% to optimize for beta as you derived in the exercise
	beta = lda_optimize_beta(X,phi,gamma,alpha,K,V,M);
	alpha_energy_fn = @(a) alpha_energy_functional(a,gamma);
	
	% Call Newton-Raphson method. Our implementation of 
	% this method expects a special structured Hessian. Refer
	% `alpha_energy_functional.m` or `nr_ss.m` for details
	alpha = nr_ss(alpha,M,alpha_energy_fn);
end


