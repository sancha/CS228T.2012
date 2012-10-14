function [norm_err norm_err_rnd] = evaluate_clustering (X,y,P)
%% X - data
%% y - ground truth labelling
%% P - generated clustering : for each pair probability that they occur together.
%%		 if P is a vector, it is treated as the predicted label.

	[numSamples numDimensions] = size(X);
	[R C] = meshgrid(1:numSamples);
	G = sparse(y(R) == y(C));

	normalizer = inv(sqrt(prod(size(G))));

	if isvector(P)
		pred = P;
		P = sparse(P(R) == P(C));
	else
		norm_err = normalizer * norm(G-P,'fro');
		P = round(P);
	end

	norm_err_rnd = normalizer * norm(G-P,'fro');
end
