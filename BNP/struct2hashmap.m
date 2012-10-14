function hmap = struct2hashmap(S)
if ((~isstruct(S)) || (numel(S) ~= 1))
	    error('struct2hashmap:invalid','%s',...
				  'struct2hashmap only accepts single structures');
end

hmap = java.util.HashMap;
	for fn = fieldnames(S)'
		% fn iterates through the field names of S
		% fn is a 1x1 cell array
		fn = fn{1};
		hmap.put(fn,getfield(S,fn));
	end
end
