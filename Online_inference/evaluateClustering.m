function [norm_err rand_err] = evaluateClustering (X,y,P)
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
	P = round(P);
end

norm_err = normalizer * norm(G-P,'fro');

connected = find(G);
rand_err = 1-(full(sum(P(connected)))/numel(connected));
end
