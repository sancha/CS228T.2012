function [train_error test_error] = evaluate_model(w,Psi_func,soln_train_error, soln_test_error, ...
																		train_data,test_data,G,test_name)
	h_observed = true;
	max_allowed_error = 0.12;
	if strcmp(test_name,'Latent SVM with slack rescaling')
		h_observed = false;
	end

	num_train_incorrect = get_num_incorrect(w,Psi_func,G,train_data,h_observed); 
	num_test_incorrect = get_num_incorrect(w,Psi_func,G,test_data,h_observed); 

	train_error = num_train_incorrect / length(train_data.y);
	test_error = num_test_incorrect / length(test_data.y);

	fprintf('Train error: %5.3f%%\n', 100*train_error);
	fprintf('Test error:  %5.3f%%\n', 100*test_error);

	diff1 = abs(soln_train_error - train_error);
	diff2 = abs(soln_test_error - test_error);
	if (diff1 < 1e-2 & diff2 < 1e-2)
		fprintf('You got exactly our score. Good job!\n');
	elseif (train_error < max_allowed_error & test_error < max_allowed_error)
		fprintf('Your performace is adequate, but your score differs from ours\n'); 
		fprintf('This may be numerical and requires review by a grader.\n')
	else
		fprintf('The performance is inadequate, and you almost definitely have an error.\n');
	end
end

function num_incorrect = get_num_incorrect(w,Psi_func,G,data,h_observed) 
	num_incorrect = 0;
	[D K M] = size(data.X);

	if h_observed
		num_incorrect = sum(arrayfun(@(m) is_incorrect(w,Psi_func,data.X, ...
							data.y, data.h, G, m), colvec(1:M)));
	else
		num_incorrect = sum(arrayfun(@(m) is_incorrect_latent(w,Psi_func,data.X, ...
							data.y, G, m), colvec(1:M)));
	end
end

function incorrect = is_incorrect(w,Psi_func,X,y,h,G,m) 
	[D K M] = size(X);
	z_set = cart_prod(1:G,1:K);	
	incorrect = 0;
	score_func = @(z) full(dot(w,Psi_func(X(:,:,m), z(1), z(2))));
	scores = cellfun(score_func,z_set);
	[val z_ind] = max(scores);
	z_hat = z_set{z_ind};
	if z_hat(1,1) ~= y(m) | z_hat(1,2) ~= h(m)
		incorrect = 1;
	end
end

function incorrect = is_incorrect_latent(w,Psi_func,X,y,G,m) 
	[D K M] = size(X);
	z_set = cart_prod(1:G,1:K);	
	incorrect = 0;
	score_func = @(z) full(dot(w,Psi_func(X(:,:,m), z(1), z(2))));
	scores = cellfun(score_func,z_set);
	[val z_ind] = max(scores);
	z_hat = z_set{z_ind};
	if z_hat(1,1) ~= y(m)
		incorrect = 1;
	end
end

