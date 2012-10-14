%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Read startup.m for startup instructions 
%% IMPORTANT : You may need to modify the pointer to your installation of pmtk
fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 7\n\n');
fprintf('Structure learning\n');

m = 1000000;
d = 3;
n = 11;
%% X = data_gen_mrf(m,d);
%% data.mat contains the output from data_gen_mrf
load 'data.mat';

scopes = cell(15,1);
%% Candidate factor scopes
scopes{1} = [1 2 3];
scopes{2} = [4 5 6 7];
scopes{3} = [1 3];
scopes{4} = [2 5 9];
scopes{5} = [4 7];
scopes{6} = [5 7];
scopes{7} = [3 8 10 11];
scopes{8} = [7 9 11];
scopes{9} = [3 8];
scopes{10} = [9 10];
%% True scopes
scopes{11} = [1 2];
scopes{12} = [2 3];
scopes{13} = [4 5 6];
scopes{14} = [6 7];
scopes{15} = [8 9 10 11];

%% Please do not change ANY of the tunable paramteres provided
lambda = 0.1;
sizes = ones(1,n) * d;

%% All scores are calculated as likelihood_fn(..) + reg_fn(..)
reg_fn = @(f) group_lasso(f, lambda);

[factors scopes af_ind] = mrf_structure_fit(X,scopes,sizes,reg_fn,lambda);
evaluate_structure(factors, scopes, sizes, af_ind, m);
