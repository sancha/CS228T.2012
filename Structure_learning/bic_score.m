function score = bic_score(factors, scopes, af_ind, sizes, emp_exp, m)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%% Calculates the BIC score of a given structure as in KF Section 18.3.5

	score = likelihood_fn(emp_exp, factors, scopes, sizes); 
	score = score - 0.5 * log(m) * inv(m) * sum(cellfun(@(scope) prod(sizes(scope)), scopes(af_ind)));
end
