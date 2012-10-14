function cartprod = cart_prod(v1, v2)
	l1 = length(v1);
	l2 = length(v2);
	cartprod = repmat(colvec(v1), [l2 2]);
	for i=1:l1*l2
		cartprod(i,2) = ceil(i/l1);
	end
	cartprod = mat2cell(cartprod, ones(1,l1*l2), 2);
end
