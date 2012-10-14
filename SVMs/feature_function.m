function Psi = feature_function(x,y,h,g)
	%% x is a 2D data item
	[d k] = size(x);
	Psi = sparse(d*g,1);
	Psi(d*(y-1)+1 : d*y) = x(:,h);
end
