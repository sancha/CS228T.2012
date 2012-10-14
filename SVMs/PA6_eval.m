%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Read startup.m for startup instructions 
%% IMPORTANT : You may need to modify the pointer to your installation of pmtk
fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 6\n\n');

M = 8000;	% number of samples
G = 4;		% number of different labels
D = 2;		% dimensionality of each column of each sample (Refer to the writeup)
K = 2;		% number of values the hidden variable h can take 

train_ratio = 0.1;
[train_data test_data mu_dist] = svm_data_gen(M,K,G,D,train_ratio);

do_slack = 1;
do_margin = 1;
do_latent = 1;
do_admm = 1;

options = struct();
problem = struct();

problem.G = G;
problem.C = 10;
problem.epsilon = 1e-4;
problem.max_iters = 100;
problem.data = train_data;

[problem.D problem.K problem.M] = size(problem.data.X);
problem.n = problem.D * problem.G;

problem.Delta_func = @(y,y_hat) mu_dist(y,y_hat)/max(max(mu_dist));
problem.Psi_func = @(x,y,h) feature_function(x,y,h,G);

randn('seed',0);
problem.w0 = randn(problem.n,1);
eval_func =@(w,test_name,soln_train_error,soln_test_error) evaluate_model ...
				(w,problem.Psi_func,soln_train_error,soln_test_error, ...
				train_data,test_data,G,test_name);

if do_slack
	test_name = 'Slack rescaling';
	fprintf('\n%s\n\n',test_name);
	options.scale = 'slack';
	w_slack = svm_struct(problem,options);
	[train_error test_error] = eval_func(w_slack,test_name,0.10625,0.09264);
end

if do_margin 
	test_name = 'Margin rescaling';
	fprintf('\n%s\n\n',test_name);
	options.scale = 'margin'; 
	w_margin = svm_struct(problem,options);
	[train_error test_error] = eval_func(w_margin,test_name,0.10875,0.09167);
end

if do_admm
	test_name = 'ADMM splitting across examples with slack rescaling';
	fprintf('\n%s\n\n',test_name);
	
	problem.rho = 0.5;
	problem.N = 2;
	problem.epsilon_abs = 0.01; 
	problem.epsilon_rel = 0.01;
	
	options.scale = 'slack'; 
	w_sae = svm_struct_sae(problem,options);
	[train_error test_error] = eval_func(w_sae,test_name,0.105,0.09181);
end

if do_latent
	test_name = 'Latent SVM with slack rescaling';
	fprintf('\n%s\n\n',test_name);
	problem.epsilon_outer = 0.1;
	problem.max_iters_outer = 50;
	problem.data.h = [];
	
	options.scale = 'slack';  
	w_latent = svm_latent_struct(problem,options);
	[train_error test_error] = eval_func(w_latent,test_name,0.10125,0.08681);
end
