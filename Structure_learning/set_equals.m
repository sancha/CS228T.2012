function is_equal = set_equals(set1, set_gt)
	is_equal = 0;
	if length(set1) == length(set_gt) & ...
		length(intersect(set1, set_gt)) == length(set_gt)
		is_equal = 1;
	end
end
