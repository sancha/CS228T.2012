function [ratings variances] = batchEPTrueSkill(G,W,blockSize)
%% Performs a single sweep of EP over the games data in blocks,
%% performing multiple iterations of message passing per block of data
%% to approximately calculate the mean and the variance of each 
%% player's skill.

%% Refer the handout for details of the model

%% Inputs:
%%		G (M x 2) : G(i,1) is the winner of the i-th game, 
%%						and G(i,2) is the loser of the i-th game
%%		W (N x 1) : cell-array with W{i} the name of the i-th player

	M = size(W,1);       % number of players
	N = size(G,1);       % number of games in 2011 season 
	pv = 0.5;            % prior skill variance (prior mean is always 0)

	epsilon = 1e-2;
	maxIters = 100;
	
	blocks = blockify(G,blockSize);
	numBlocks = numel(blocks);
	
	% struct to store the auxiliary variables. 
	% see initAux and updateAux for details
	aux = initAux(W,M,pv); 

	%% Initializing the messages from the game nodes to the skill nodes
	mgs = Message(zeros(M,1), zeros(M,1));
	
	for i=1:numBlocks	
		aux = updateAux(aux,blocks,i,blockSize);
		
		old_mgs_batch = Message(zeros(aux.N,2), zeros(aux.N,2));
		
		for iter=1:maxIters
			fprintf('.');

			%% Message from skill nodes to game nodes
			msg = msgSkillToGame(mgs,old_mgs_batch,aux);
				
			%% Message from game nodes to performance nodes
			mgp = msgGameToPerformance(msg,aux);
			
			%% Message from performance nodes to game nodes
			mpg = msgPerformanceToGame(mgp,aux);
			
			%% Message from game nodes to skill nodes
			mgs_batch = msgGameToSkill(mpg,msg,aux);
	
			deltaMgs = calculateDeltaMgs(mgs_batch,old_mgs_batch,aux);
		
			mgs.P = mgs.P + deltaMgs.P;
			mgs.h = mgs.h + deltaMgs.h;
		
			if (norm(deltaMgs.P) + norm(deltaMgs.h) < epsilon)
				break;
			end
			old_mgs_batch = mgs_batch;
		end
	end

	[ratings variances] = getRatings(mgs,aux);
end

function [ratings variances] = getRatings(mgs,aux)	
	%% INSERT CODE HERE %%
	% (0) compute the vectors of means and variances of the skills	
	
end

function	msg = msgSkillToGame(mgs,mgs_batch,aux) 
	%% INSERT CODE HERE %%
	% (1) compute skill node beliefs 
	% (2) compute skill to game messages

	msg = Message(Psg,hsg);
end

function mgp = msgGameToPerformance(msg,aux)
	%% INSERT CODE HERE %%
	% (3) compute game to performance messages
	% Remember that player 1 always wins the way we store data
	
	mgp = Message(Pgp,hgp);
end

function mpg = msgPerformanceToGame(mgp,aux)	
	%% Useful functions 
	psi = inline('normpdf(x)./normcdf(x)');
	lambda = inline('(normpdf(x)./normcdf(x)).*( (normpdf(x)./normcdf(x)) + x)');

	%% INSERT CODE HERE %%
	% (4) project as in line 1 of KF Algorithm 11.5 (pg 441)
	% (5) compute performance to game messages as in line 4 
	%		of the same algorithm

	mpg = Message(Ppg,hpg);
end

function mgs = msgGameToSkill(mpg,msg,aux)
	%% INSERT CODE HERE %%
	% (6) compute game to skills messages
  
	mgs = Message(Pgs,hgs);
end

function deltaMgs = calculateDeltaMgs(mgs_batch, old_mgs_batch, aux)
	deltaMgs = Message(zeros(aux.M,1), zeros(aux.M,1));
	for j=1:length(aux.players)
		p = aux.players(j);
		deltaMgs.P(p) = sum(mgs_batch.P(aux.G==p)) ...
					- sum(old_mgs_batch.P(aux.G==p)); 
		deltaMgs.h(p) = sum(mgs_batch.h(aux.G==p)) ...
					- sum(old_mgs_batch.h(aux.G==p)); 
	end
	fprintf('%f\n', norm(deltaMgs.P) + norm(deltaMgs.h));
end

function aux = initAux(W,M,pv)
	aux = struct();
	aux.W = W;
	aux.M = M;
	aux.pv = pv;
end

function aux = updateAux(aux,blocks,i,blockSize)
	aux.G = blocks{i};
	aux.N = size(aux.G,1);
	aux.blockBegin = (i-1)*blockSize + 1;
	aux.blockEnd = aux.blockBegin + aux.N - 1;
	aux.players = unique(aux.G(:));
end

function blocks = blockify(X,blockSize)
	blocks = {};
	[numSamples numDimensions] = size(X);
	numBlocks = ceil(numSamples/blockSize);
	for i=1:numBlocks
		startPos = (i-1)*blockSize+1;
		endPos = min(numSamples,i*blockSize);
		blocks{i} = X(startPos:endPos,:);
	end
end

