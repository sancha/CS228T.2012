function alpha_star = nr_ss(alpha,M,alpha_energy_fn)
%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University
%
% Newton Raphson method for Hessian with special structure
% H = diag(h) + z * ones(length(h))
%
% You won't need to modify anything here.

	fprintf('\tITER\t FVAL \t\t NORM(G) \t NORM(S_G)\n');
	tol = 1e-1;
	eps = 1e-3;
	max_iters = 50;
	s_g = -Inf;
	for iter = 1:max_iters
		alpha_0 = sum(alpha);
		[fval g h z] = alpha_energy_fn(alpha);
		fprintf('\t%d \t %7.5f \t %7.5f \t %7.5f\n',iter, fval, norm(g), norm(s_g));
		if norm(g)<tol
			break;
		end
		s_g = hss(g,h,z);
		alpha = alpha - s_g;
		assert(~any(alpha<0));
	end
	alpha_star = alpha;
end

function s_grad = hss(g,h,z)
%% Computes inv(diag(h) + z*ones(length(h))) * g
	c = sum(g./h)/(inv(z) + sum(1./h));
	s_grad = (g-c)./h;
end

