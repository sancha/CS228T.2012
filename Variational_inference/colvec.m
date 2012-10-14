function v = colvec(a)
	if size(a,1) == 1
		v = a';
	else
		v = a;
	end
end
