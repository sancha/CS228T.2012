function norm_mat = normalize_rows(mat)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Normalize the rows such that each row sums upto 1.
% ie., sum(mat,2) = 1

	norm_mat = bsxfun(@rdivide, mat, sum(mat,2));
end

