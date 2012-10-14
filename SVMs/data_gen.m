function [X y mu_dist] = data_gen(num_samples,num_gaussians,num_dimensions) 
%% Generates a Mixture of Gaussians dataset

%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

	X = []; 
	y = [];
	seed = 0;
	rand('seed',seed);
	randn('seed',seed);
	%% theta - the probability for different gaussians sampled from Dirichlet
	theta = drchrnd(ones(1,num_gaussians) * 20,1);

	%% each row vector is the mean for different gaussians
	sigma_scale_factor = 160;
	mu_scale_factor = sqrt(12*num_gaussians);

	mu = randn(num_gaussians,num_dimensions) * mu_scale_factor;
	mu_dist = squareform(pdist(mu));

	Sigma = zeros(num_dimensions, num_dimensions, num_gaussians);
	R = zeros(num_dimensions, num_dimensions, num_gaussians);       
	
	sigma_model = struct();
	sigma_model.Sigma = eye(num_dimensions)*sigma_scale_factor;
	sigma_model.dof = 15;
	Sigma = invWishartSample(sigma_model,num_gaussians);
	num_per_gaussian = mnrnd(num_samples,theta);

	for i=1:num_gaussians
		R(:,:,i) = chol(Sigma(:,:,i));
		Xi = repmat(mu(i,:),num_per_gaussian(i),1) + randn(num_per_gaussian(i),num_dimensions)*R(:,:,i);
		X = [ X; Xi ];
		y = [ y; i*ones(num_per_gaussian(i),1) ];
	end

	perm = randperm(num_samples);
	X = X(perm,:);
	y = y(perm);
end

