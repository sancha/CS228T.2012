function [train_data test_data mu_dist] = svm_data_gen(M,K,G,D,train_ratio) 
	%% M - num_samples
	%% K - num_hidden_vals
	%% G - num_gaussians
	%% D - num_dimensions of each Gaussian
	%% (K x D) == n == numel(X)

	[A y mu_dist] = data_gen(M,G,D);
	A = [A ones(M,1)];
	h = ceil(rand(M,1)*K);
	X = randn(1+D,K,M);

	for k=1:K
		ind = find(h==k);
		X(:,k,ind) = A(ind,:)';
	end

	[train_data test_data] = split_data(X,y,h,train_ratio);
end

function [train_data test_data] = split_data(X,y,h,train_ratio)
	M = size(X,3);
	train_end = ceil(M*train_ratio);
	train_ind = 1:train_end;
	test_ind = train_end+1:M;

	train_data = struct();
	train_data.X = X(:,:,train_ind);
	train_data.y = y(train_ind);
	train_data.h = h(train_ind);

	test_data = struct();
	test_data.X = X(:,:,test_ind);
	test_data.y = y(test_ind);
	test_data.h = h(test_ind);
end

