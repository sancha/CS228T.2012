function f = strip(factors)
	%% Get the cell array of factors from the structure representation of pmtk
	f = cellfun(@(x) x.T, factors, 'UniformOutput', false);
end

