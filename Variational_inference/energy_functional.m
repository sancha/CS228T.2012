function fval = energy_functional(X,phi,gamma,alpha,beta)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Calculates the energy functional
% Input:
% X:	cell array where each cell contains a document
%		Each document is represented as a vector of word indices
% 
% phi:	(M x 1) cell array, each of size (N x K), N is the
%			number of words in the doc. Variational multinomial parameter
% gamma: (M x K) is the variational Dirichlet parameter
% alpha:	(1 x K) the Dirichlet prior over theta
% beta:	(K x V) `beta(i,:)` specifies the multinomial distribution 
%			over words for the topic `i`

	M = length(phi);
	dataset = colvec(1:M);
	fval = sum(arrayfun(@(m) energy_functional_fn(X,phi,gamma,alpha,beta,m), dataset));
end

function fval = energy_functional_fn(X,phi,gamma,alpha,beta,m)
	gamma = gamma(m,:);
	phi = phi{m};
	X = X{m};
	alpha_0 = sum(alpha);
	gamma_0 = sum(gamma);
	t = zeros(?,1);

	%% (1) INSERT CODE HERE

	debug(m,gamma,t);
	fval = sum(t);
end

function debug(m,gamma,t)
	if(any(isinf(t)) | any(isnan(t)))
		fprintf('%d [',m);
		fprintf('%5.3f ',gamma);
		fprintf('] --');
		fprintf('[');
		fprintf('%5.3f ',t);
		fprintf(']\n');
	end
end
