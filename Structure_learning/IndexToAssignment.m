%INDEXTOASSIGNMENT Convert index to variable assignment.
%
%   A = INDEXTOASSIGNMENT(I, D) converts an index, I, into an assignment
%   over variables with dimensionality D. If I is a vector, then produces
%   a matrix of assignments.
%
%   See also ASSIGNMENTTOINDEX

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function A = IndexToAssignment(I, D);

%D = D(:)'; % ensure that D is a row vector
A = mod(floor(repmat(I(:) - 1, 1, length(D)) ./ ...
    repmat(cumprod([1, D(1:end - 1)]), length(I), 1)), ...
    repmat(D, length(I), 1)) + 1;
