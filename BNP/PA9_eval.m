%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Read startup.m for startup instructions 
%% IMPORTANT : You may need to modify them
fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 9\n\n');

%% mandatory section, collapsed Gibbs sampling for DPMM %%
numSamples = 3000;
numGaussians = 4;
numDimensions = 2;

[X y] = dataGen(numSamples,numGaussians,numDimensions); 
plotData (numGaussians,X,y,'Ground truth');

maxError = 0.3;

do_dp_gibbs = true;
do_hdp = false;

if do_dp_gibbs
	m0 = zeros(numDimensions,1);
	S0 = eye(numDimensions,numDimensions) * 20;
	nu0 = 50;
	alpha = 5;
	kappa0 = 5;
	K0 = 8;

	P = dp_cg(X,K0,alpha,m0,kappa0,S0,nu0);
	[norm_err norm_err_rnd] = evaluate_clustering (X,y,P)
	printTestResults(norm_err, 0.23317, maxError, 'DP Collapsed Gibbs');
end

%% extra credit, HDP-LDA on (really) dummy data %%
alpha = 2;
gamma = 5;
lambda = .1;
V = 10;
N = ones(1,10) * 4; 

H.dir = ones(1,V) * (lambda/V);
H.base = true;

[X, G0, G, labels] = data_gen_hdp(gamma,H,alpha,N);
if do_hdp
	[P z] = hdp_inference_da(X,gamma,H,alpha);
	[norm_err norm_err_rnd] = evaluate_clustering (X,labels,P);
	printTestResults(norm_err, -1, maxError, 'HDP-LDA');
end

if do_dp_var_inf
	m0 = zeros(numDimensions,1);
	S0 = eye(numDimensions,numDimensions) * 20;
	nu0 = 50;
	alpha = 5;
	kappa0 = 5;
	K0 = 8;

	P = dp_var_inf(X,K0,alpha,m0,kappa0,S0,nu0);
	[norm_err norm_err_rnd] = evaluate_clustering (X,y,P)
	printTestResults(norm_err, -1, maxError, 'DP Mean field method');
end
