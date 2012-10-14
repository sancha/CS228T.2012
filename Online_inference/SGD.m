function w = SGD(w0, options, X, y, lambda)
% Implement some version of Stochastic Gradient Descent.
% You can control the step size, the batch size, the number of iterations and the tolerance.
% The only requirement is that you get a reasonable performance, as evaluated by the test script.

	[m n] = size(X);	
	%% m = number of data items
	%% n = feature length

	batchsize =  getOpt(options,'batchsize', 1);

	[batchdata, batchlabels] = batchify(X, y, batchsize);
	num_batches = numel(batchlabels);

	for b=1:num_batches

		%% INSERT CODE HERE

	end
end

%% These functions are from PMTK
function [batchdata, batchlabels] = batchify(X, y, batchsize)
	nTrain = size(X,1);
	num_batches = ceil(nTrain/batchsize);
	groups = repmat(1:num_batches,1,batchsize);
	groups = groups(1:nTrain);
	batchdata = cell(1, num_batches);
	batchlabels = cell(1, num_batches);
	for i=1:num_batches
		batchdata{i} = X(groups == i,:);
		batchlabels{i} = y(groups == i,:);
	end
end

function [v] = getOpt(options,opt,default)
if isfield(options,opt)
    if ~isempty(getfield(options,opt))
        v = getfield(options,opt);
    else
        v = default;
    end
else
    v = default;
end
end
