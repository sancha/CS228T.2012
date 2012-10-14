function [w xi fval] = svm_struct(problem,options)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%%	Solves the structural SVM problem using the 1-slack formulation as in
%% Joachims, Finley and Yu '09 algorithms 3 and 4
%%
%% problem: struct with the following fields
%%		G:		The number of distinct labels
%%		D:		Dimension of each column of each sample
%%		K:		Number of values the hidden variable can take on
%%		M:		Number of data samples
%%		n:		Size of w = D * G
%%		data: struct with the following fields
%%			X:	(D x K x M) matrix where X(:,i,j) 
%%				is the feature vector corresponding to the
%%				j-th instance under h_j=i.  
%%			y:	(M x 1) vector where y_j is the label of j-th instance
%%			h: (M x 1) where h_j is the hidden variable corresponding 
%%				to the j-th instance
%%		w0:	Initialization of w
%%		xi0:	Initialization of \xi 
%%		epsilon:	Refer to Joachims, Finley and Yu '09
%%		max_iters
%%		Psi_func:	Psi_func(X(:,:,j),y,h) is the feature function
%%		Delta_func: Delta_func(y,y_hat) is the loss
%%
%%		sae:	1 if being called by ADMM as a subproblem
%%		proximal_offset: only relevant if sae == 1. Refer the writeup 
%%
%%	options:
%%		scale:	{'slack','margin'} 
%%					if scale == 'slack', this algorithm must use slack rescaling
%%					and margin rescaling otherwise
%%
		
	D = problem.D; 
	K = problem.K;
	M = problem.M;
	G = problem.G;

	if isfield(problem,'w0') 
		w = problem.w0;
	else
		w = randn(problem.n,1);
	end

	if isfield(problem,'xi0')
		xi = problem.xi0;
	else
		xi = 0;
	end
	
	%% INSERT CODE HERE %%
	% (0) Initializations 
			
	for iter=1:problem.max_iters
		fprintf('.');
	
		%% INSERT CODE HERE %%
		% (1) Structural SVM code here 
	
	end
	fprintf('\n');
end

