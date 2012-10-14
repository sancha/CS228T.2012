function V = gemrnd_trunc(alpha,T)
	V = betarnd(1,alpha,[T 1]);
	V(T) = 1;
end
