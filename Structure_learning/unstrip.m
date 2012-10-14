function ufactors = unstrip(factors, scopes, sizes)
	%% Convert back to pmtk format
	ufactors = cell(length(factors),1);
	for i=1:length(factors)
		ufactors{i}.T = factors{i};
		ufactors{i}.domain = scopes{i};
		ufactors{i}.sizes = sizes(scopes{i});
	end
end

