function [fval grad] = group_lasso(factors, lambda)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Implements block L1 regularization where each factor corresponds
%% to a block. Refer to section 20.7.3.3 in KF for details.
%% Also calculate the gradient and return it

%% Its usage requires the output to be scaled by -Lambda.
%% ie. -\Lambda * L1(L2(factor{i}))		

	fval = 0;

	grad = cell(size(factors));	
	for i=1:length(grad)
		%% INSERT CODE HERE
		assert(~any(isnan(grad{i}(:))));
	end
end
