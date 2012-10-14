function evaluate_structure(factors, scopes, sizes, af_ind, m)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

	expected_factors = [1 13 14 15]; 
	true_factors = [11 12 13 14 15];

	fprintf('TEST 1\nLearning a good structure: ');

	if (set_equals(af_ind, expected_factors) | ...
		set_equals(af_ind, true_factors)) 
		fprintf('Good job!\n');
	elseif (length(setxor(af_ind, expected_factors)) == 1 | ...
		length(setxor(af_ind, true_factors)) == 1)
		fprintf('Your results are reasonable, but they differ from ours.\n');
		fprintf('This may be numerical and requires review.\n');
	else
		fprintf('Your results are not similar to ours!\n');
		fprintf('You probably have a bug in your code.\n')
	end

	%% If you want to be double sure, our BIC score was > -7.1
end
