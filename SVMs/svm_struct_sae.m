function w_sae = svm_struct_sae(problem,options)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%%
%% Solves the structural SVM problem while splitting across examples (sae)
%% using ADMM. See the writeup of homework 6 for details.

%% problem: A struct containing all the fields passed to svm_struct 
%%				and additional fields
%%		rho:	
%%		N:		The number of blocks
%%

	n = problem.n;
	N = problem.N;
	rho = problem.rho;
	e_abs = problem.epsilon_abs;
	e_rel = problem.epsilon_rel;
	blocks = blockify(problem.data,N);

	if ~isfield(problem,'w0')
		problem.w0 = randn(n,1);
	end
	
	%% INSERT CODE HERE %%
	% (0) Initialize the w's, z and u as in the writeup

	r = Inf;		% primal residual 
	s = Inf;		% dual residual
	e_pri = 0;	% primal tolerance
	e_dual = 0; % dual tolerance

	problem.sae = 1; 
	while norm(r,'fro') > e_pri | norm(s) > e_dual

		%% INSERT CODE HERE %%
		%% (1) Solve all N subproblems using svm_struct
		%% and passing the appropriate proximal offset

		old_z = z; 

		r = bsxfun(@minus, w, z); 
		s = rho * sqrt(N) * (z-old_z);

		[e_pri e_dual] = compute_tolerances(e_abs, e_rel, w, z, u);
	end
	
	%% INSERT CODE HERE %%
	%% (2) Return the mean of the w's
end

function blocks = blockify(data,num_blocks)
	blocks = {};
	M = size(data.X,3);
	block_size = ceil(M/num_blocks); 
	for i=1:num_blocks
		start_pos = (i-1)*block_size+1;
		end_pos = min(M,i*block_size);
		blocks{i} = struct();
		blocks{i}.X = data.X(:,:,start_pos:end_pos);
		blocks{i}.h = data.h(start_pos:end_pos);
		blocks{i}.y = data.y(start_pos:end_pos);
	end
end

function	[e_pri e_dual] = compute_tolerances(e_abs, e_rel, w, z, u)
	[n N] = size(w);
	e_pri = sqrt(n*N) * e_abs + e_rel * max([norm(w,'fro'), norm(z)*sqrt(N)]);
	e_dual = sqrt(n*N) * e_abs + e_rel * norm(u,'fro');
end

