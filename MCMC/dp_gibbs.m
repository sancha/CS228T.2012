function [P numGaussians] = dp_gibbs(X,alpha,m0,kappa0,S0,nu0)
%% Collapsed Gibbs for the Gaussian Mixture Model
%% Inputs:
%% alpha : hyperparameter for the symmetric Dirichlet prior (1 x 1)
%% m0 : hyperparameter for the mean of all the mu (numDimensions x 1) 
%% kappa0 : hyperparameter for the precision of all the mu (1 x 1)
%% S0 : hyperparameter that is proportional to the mean of all the Sigma 
%%			(numDimensions x numDimensions)  
%% nu0 : hyperparameter for the precision of all the Sigma (1 x 1) 
%% 
%% Outputs:
%% P : Pairwise probabilities for being in the same cluster.

%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

seed = 0;
rand('seed',seed);
randn('seed',seed);
figure; 

[numSamples numDimensions] = size(X);
P = sparse(numSamples, numSamples);
[R C] = meshgrid(1:numSamples);
T = 50;
burnIn = 20;

%% Initialization %%
K = 1;
z = ones(numSamples,1); 

xTot = zeros(K, numDimensions);
xBar = zeros(K, numDimensions);
xVar = zeros(numDimensions, numDimensions, K);
for s=1:K+1
	ind = find(z==s);
	xTot(s,:) = sum(X(ind,:));
	xVar(:,:,s) = X(ind,:)' * X(ind,:);
end

%% Collapsed-Gibbs phase %%
for t=1:T
	fprintf('[%d %d]',t,K);
	plotData (K,X,z,sprintf('Collapsed Gibbs %d',t),true);	
	mov(t) = getframe;
	drawnow expose% update;

	for i=1:numSamples
		Q = zeros(1,K+1);
		xTot(z(i),:) = xTot(z(i),:) - X(i,:);
		xVar(:,:,z(i)) = xVar(:,:,z(i)) -(X(i,:)'*X(i,:));
		old_z = z(i);
		z(i) = -1;
		
		for s=1:K+1
			ind = find(z==s);
			Ns = length(ind);

			%% Eqn 24.24
			if s>K
				Q(s) = alpha/(alpha+numSamples-1);
			else
				Q(s) = Ns/(alpha+numSamples-1);
			end

			if Ns == 0
				xBar(s,:) = 0;
			else
				xBar(s,:) = xTot(s,:)/Ns;
			end
			kappaN = Ns + kappa0;
			nuN = Ns + nu0;
			mN = (kappa0/kappaN) * m0 + (Ns/kappaN)*xBar(s,:)';
			SN = S0 + xVar(:,:,s) + kappa0 * m0 * m0' - kappaN * mN * mN';   

			nu = nuN-numDimensions+1;
			Q(s) = Q(s) * exp(studentLogprob(mN,((kappaN+1)/(kappaN*nu)*SN),nu,X(i,:)));
		end %% end s=1:numGaussians
		Q = Q/sum(Q);

		z(i) = find(mnrnd(1,Q,1));
		old_z_alone = isempty(find(z==old_z));

		%% emptied a cluster, but didn't create anything new
		if old_z_alone & z(i) <= K 
			z = arrayfun(@(zi) reindex(zi,old_z), z); 
			K = K-1;	
		%% emptied and created a new one, so reuse it.
		%% not emptied and created a new one
		elseif ~old_z_alone & z(i) == K+1
			K = K+1;
			xTot(z(i),:) = zeros(1,numDimensions);
			xVar(:,:,z(i)) = zeros(numDimensions,numDimensions);
		%% moved to an older cluster, do nothing
		end
		assert(length(unique(z)) == K);

		xTot(z(i),:) = xTot(z(i),:) + X(i,:);
		xVar(:,:,z(i)) = xVar(:,:,z(i)) + (X(i,:)'*X(i,:));

	end %% end 1:numSamples 

	if t>burnIn
		P = P + sparse(z(R) == z(C));
	end
end %% end i=1:T
P = bsxfun(@rdivide, P, T-burnIn);

%% Plotting the mean of mean posterior %%
for s=1:K		
	ind = find(z==s);
	Ns = length(ind);

	if Ns == 0
		xBar(s,:) = 0;
	else
		xBar(s,:) = xTot(s,:)/Ns;
	end
	kappaN = Ns + kappa0;
	nuN = Ns + nu0;
	mN = (kappa0/kappaN) * m0 + (Ns/kappaN)*xBar(s,:)';
	SN = (S0 + xVar(:,:,s) + kappa0 * m0 * m0' - kappaN * mN * mN')/nuN;   
	
	%% INSERT CODE HERE %%
	%% Calculate the posterior hyperparameters SN 
	%% (numDimensions x numDimensions) and mN (numDimensions x 1)
	%% corresponding to the s-th cluster.
	
	hold on; 
	confidenceEllipse(SN,mN,'style','k.');
	scatter(mN(1),mN(2),'ko','filled');
end

movie(mov,1);
end

function out = reindex(zi,old_z)
	if zi > old_z
		out = zi-1;
	else
		out = zi;
	end
end


function re_index
	unique_z = sort(unique(z),'ascend');
	K = length(unique_z);
	map(unique_z) = 1:K;
	z = map(z);
	xTot = [ xTot(map(unique_z),:); zeros(1,numDimensions) ];
	xVar = xVar(:,:,map(unique_z));
	xVar(:,:,1+K) = zeros(numDimensions,numDimensions);
end
