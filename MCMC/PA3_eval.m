%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

%% Read startup.m for startup instructions 
%% IMPORTANT : You may need to modify them
fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 3\n\n');


numSamples = 3000;
numGaussians = 4;
numDimensions = 2;

[X y] = dataGen(numSamples,numGaussians,numDimensions); 
plotData (numGaussians,X,y,'Ground truth');

maxError = 0.3;

do_gibbs = true;
do_collapsed_gibbs = true;

if do_gibbs 
	%% See comments inside gibbs.m for explanation of arguments 
	alpha = ones(1,numGaussians)/numGaussians;
	m0 = zeros(numDimensions,1);
	V0 = eye(numDimensions,numDimensions) * 20;
	S0 = eye(numDimensions,numDimensions) * 20;
	nu0 = 50;
	P = gibbs(X,numGaussians,alpha,m0,V0,S0,nu0);
	
	[gibbsNrmError gibbsRndError] = evaluateClustering(X,y,P);
	printTestResults(gibbsNrmError, 0.2849, maxError, 'Gibbs');
end

if do_collapsed_gibbs
	%% See comments inside collapsedGibbs.m for explanation of arguments 
	m0 = zeros(numDimensions,1);
	S0 = eye(numDimensions,numDimensions) * 20;
	nu0 = 50;
	alpha = 30;
	kappa0 = 5;
	
	P = collapsedGibbs(X,numGaussians,alpha,m0,kappa0,S0,nu0);
	[cgNrmError cgRndRrror] = evaluateClustering(X,y,P);
	printTestResults(cgNrmError, 0.2553, maxError, 'Collapsed Gibbs');
end
