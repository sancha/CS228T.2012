function evaluate_milestones(X,K,V,final_fval)
%% These tests are randomly generated and are not aimed 
%% at testing corner cases. 

	load('lda_tests.mat');
	n_test = length(test);
	tol = 1e-5;
	M = length(X);
	N = cellfun(@(x) length(x), X);
	
	%% TEST 1 %%
	fprintf('TEST 1: Full optimization result check:\n')
	if abs(final_fval+206596.648530) < tol
		fprintf('TEST 1: PASSED!\n\n');
	else
		fprintf('TEST 1: FAILED!\n\n');
	end


	%% TEST 2 %%
	test2_status = true;
	fprintf('TEST 2: The energy functional test: \n');
	for i=1:n_test 
		fval = energy_functional(X,test{i}.phi,test{i}.gamma,test{i}.alpha,test{i}.beta);
		if(abs(fval-test{i}.fval) > tol)
			test2_status = false;
			break;
		end
	end

	if test2_status == false
		fprintf('TEST 2: FAILED!\n\n');
	else
		fprintf('TEST 2: PASSED!\n\n');
	end

	%% TEST 3 %%
	test3_status = true;
	fprintf('TEST 3: lda_estep_fn test:\n');
	for i=1:n_test 
		params = lda_estep_fn(X,test{i}.alpha,test{i}.beta,V,K,M,N,1);

		diffr1 = norm(test{i}.opt_phi - params.phi,'fro');
		if(diffr1 > tol)
			fprintf('TEST 3: lda_estep_fn returns faulty phi matrix.');
			fprintf('The norm difference is: %f\n',diffr1);
			test3_status = false;
			break;
		end
		
		diffr2 = norm(test{i}.opt_gamma - params.gamma);
		if(diffr2 > tol)
			fprintf('TEST 3: lda_estep_fn returns faulty gamma vector.');
			fprintf('The norm difference is: %f\n',diffr2);
			test3_status = false;
			break;
		end
	end
	if test3_status == false
		fprintf('TEST 3: FAILED!\n\n');
	else
		fprintf('TEST 3: PASSED!\n\n');
	end

	%% TEST 4 %%
	test4_status = true;
	fprintf('TEST 4: lda_optimize_beta test:\n');
	beta = lda_optimize_beta(X,test{1}.phi,test{1}.gamma,test{1}.alpha,K,V,M);

	diffr = norm(beta-test{i}.opt_beta,'fro');
	if(diffr > tol)
		test4_status = false;
		fprintf('lda_optimize_beta returns faulty beta.')
		fprintf('The norm difference is: %f\n',diffr);
	end

	if test4_status == false
		fprintf('TEST 4: FAILED!\n\n');
	else
		fprintf('TEST 4: PASSED!\n\n');
	end

end
