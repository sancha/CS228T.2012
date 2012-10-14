%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 8\n\n');
fprintf('Variational inference in Topic models\n');

load lda_data_tiny.mat

[alpha beta fval] = lda(X,V,K);
evaluate_milestones(X,K,V,fval);

%% In case you are curious what data you are working on
%% you can uncomment these lines to see the word distributions
%% but the data is very small to have coherent topics.

%J=10;
%word_dist = cell(J);
%for k=1:K
% 	[sorted pop_words_k] = sort(beta(k,:),'descend');
%	for j=1:J
%		word_dist{j,k} = words{pop_words_k(j)};
%	end
%end

