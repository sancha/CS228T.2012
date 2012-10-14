function X = mrf_sample(m, factors)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

	exp_factors = factors_exp(factors);
	factor_prod = tabularFactorMultiply(exp_factors);
	[T Z] = tabularFactorNormalize(factor_prod);	
	X = tabularFactorSample(T,m);		
end

