function [factors scopes af_ind] = mrf_structure_fit(X,scopes,sizes,reg_fn,lambda)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Implements Greedy score based structure search algorithm as in KF Algorithm 20.1
%% with the following input
%% \Omega:  The set of candidate factor scopes, passed in as `scopes` 
%% F_0: 	{}, The initial set of features chosen is the empty set
%% score:	Block L1-score, one block per factor

%% Return:
%% (F,\theta): Return all scopes and factors, and index of the selected factors
%%				as `af_ind` (active_factors_index) so that (F,\theta) corresponds
%%				to `scopes(af_ind)` and `factors(af_ind)` 

%% Other details of implementing Algorithm 20.1
%% Parameter-Optimize: gradient_ascent with backtracking line search
%% To choose the factor to add (line 12) use block grafting as generalization 
%% of section 20.7.5

%% Other input:
%% X: 		training data, one per row
%% sizes:	Vector containing dimensionality of each variable in the model
%% reg_fn:	Regularization function handle. Note that scores are calculated
%%			as likelihood_fn(..) + reg_fn(..)
%% lambda:	Block-L1 regularization co-efficient. Termination criteria, see below

%% Use PMTK for inference:
%% You can quickly perform using the junction tree library of Pmtk3, but 
%% be careful about whether your factors are in log-space or not.
%
%% cg = cliqueGraphCreate(factors, sizes);
%% [jt logZ] = jtreeCalibrate(jtreeCreate(cg,'cliqueConstraints', scopes));
%% betas = strip(jtreeQuery(jt, scopes));
% 
%% tabularFactorCreate(..) is also helpful
	af_ind =  [];
	tol = 1e-1;
	threshold = 1e-3; 

	while true	
		%% break if L2 norm of the gradients of all factors < 2*lambda

		%% INSERT CODE HERE

		%% Or break if there is change in score is below tolerance
		if score - prev_score < tol 
			break;
		end
	end
end

