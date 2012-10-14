function w = svm_latent_struct(problem,options)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%% 
%% Solves the Latent structural SVM problem using CCCP as described in Yu & Joachims 09
%%
%% problem: A struct containing all the fields passed to svm_struct 
%%				and additional fields
%%
%%		epsilon_outer
%%		max_iters_outer

	%% INSERT CODE HERE %%
	% (0) Initializations 

	if ~isfield(problem,'w0')
		problem.w0 = randn(problem.n,1);
	end
	w = problem.w0; 
	problem.xi0 = 0; 

	for iter = 1:problem.max_iters_outer
		%% INSERT CODE HERE %%
		% (1) Latent Structural SVM code here
	end	

end

