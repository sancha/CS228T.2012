function [X factors] = data_gen_mrf(m,d)
% X1--X2--X3

% X4--X5
% \   /
%  X6
%  |
%  X7

% Clique(X8 ... X11)

rand('seed',11);
randn('seed',11);

scopes = cell(5,1);
scopes{1} = [1 2];
scopes{2} = [2 3];
scopes{3} = [4 5 6];
scopes{4} = [6 7];
scopes{5} = [8 9 10 11];

factors = cell(length(scopes),1);
for i=1:length(factors)
	factors{i} = tabularFactorCreate(exp(2 + 2 * -rand(d*ones(1,length(scopes{i})))), scopes{i});
end	

X = mrf_sample(m,factors(1:2));
X = [X mrf_sample(m,factors(3:4))];
X = [X mrf_sample(m,factors(5))];

