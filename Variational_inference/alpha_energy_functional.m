%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

function [fval g h z] = alpha_energy_functional(alpha,gamma)
% Calculates the energy functional as only the sum of the terms 
% containing alpha, the gradient `g` and the Hessian of this function
% calculated at `alpha`. Note that `h` is a vector and the Hessian 
% is of the form `diag(h) + z * ones(length(h))`
% Input:
% alpha:	(1 x K) the Dirichlet prior over theta
% gamma: (M x K) is the variational Dirichlet parameter

	M = size(gamma,1);
	dataset = colvec(1:M);
	fval = sum(arrayfun(@(m) alpha_energy_functional_fn(alpha,gamma,m), dataset));

	gamma_0 = sum(gamma,2);
	alpha_0 = sum(alpha);
	
	%% (4a) INSERT CODE HERE

end

function fval = alpha_energy_functional_fn(alpha,gamma,m)
	%% Calculates the alpha_energy_functional due to a single
	%% document

	gamma = gamma(m,:);
	t = zeros(?,1);
	alpha_0 = sum(alpha);
	gamma_0 = sum(gamma);

	%% (4b) INSERT CODE HERE
	
	fval = sum(t);
end

