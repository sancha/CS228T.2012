function factors = mrf_grad_ascent(emp_exp, factors, scopes, sizes, reg_fn)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Performs gradient ascent on the regularized likelihood
%% as KF Algorithm A.10

%% emp_exp:	Empirical expectations of the factors
%% factors:	Cell array of factors in the model
%% scopes:	Scopes are stored as a cell array of vectors of variable 
%%				indices, with one-to-one correspondence to factors
%% sizes:	Vector containing dimensionality of each variable in the model
%% reg_fn:	Regularization function handle. Note that scores are calculated
%%			as likelihood_fn(..) + reg_fn(..)

	%% Do not alter any of these parameters
	tol = 1e-3;	
	
	%% line search parameters, for backtracking line search 
	%% Refer to algorithm 9.2 in Boyd  & Vandenderghe
	a = 0.3; b = 0.9;

	while true
		%% Consider using strip and unstrip if Pmtk's factor 
		%% representation is difficult to handle 

		
		%% Delta is as in Algorithm KF A.10, line 5
		if (delta < tol)
			break;
		end
	end
end

