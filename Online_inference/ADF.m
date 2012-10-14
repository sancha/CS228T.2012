function [w_tMean w_tVariance] = ADF (X,y,Lambda)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%% Implement ADF for Logistic regression as in section 2 of Zoeter07.

	[m n] = size(X);
	%% m = number of data items
	%% n = feature length

	wPriorMean = zeros(n,1);
	wPriorVariance = ones(n,1) * (1/Lambda);

	%% INSERT CODE HERE 

	for t=1:m
		%% Getting the t-th data / observations.
		x_t = X(t,:);
		y_t = y(t);
	
		%% INSERT CODE HERE 
		
		if (mod(t,500) == 0)
			fprintf('.');
		end

	end
	fprintf('\nOnline update complete. %d\n',n);
end
