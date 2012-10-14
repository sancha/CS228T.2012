%% CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)
%% Copyright (C) 2012, Stanford University

fprintf ('CS228T Structured Probabilistic Models : Theoretical foundations (Spring 2012)\n');
fprintf ('Programming Assignment 3\n\n');

load data;

M = size(W,1);
[skillMeans variances] = batchEPTrueSkill(G,W,100); 
[sorted_skillMeans ind] = sort(skillMeans,'descend');

fprintf('\n\n');
for i=1:10
	fprintf('%d %3.2f %s\n', i, skillMeans(ind(i)), W{ind(i)});
end

for i=1:M
	rankings(i) = find(ind == i);
end

diff = mean(abs(rankings - soln_rankings));
fprintf('\n')

if (diff < 1e-2)
	fprintf('You got exactly our score. Good job!');
elseif (diff < 0.5)
	fprintf('your performace is adequate, but your score differs from ours\n'); 
	fprintf('This may be numerical and requires review by a grader.')
else
	fprintf('The performance is inadequate, and you almost definitely have an error.');
end

range = 1:numel(W);
errorbar(1:numel(range),skillMeans(ind(range)),variances(ind(range)),'rx');

totalGames = arrayfun(@(p) sum(G(:)==p), 1:M);
totalWins = arrayfun(@(p) sum(G(:,1)==p), 1:M);
naiveSkills = -2 + (totalWins ./ totalGames) * 4;

hold on;
errorbar(1:numel(range),naiveSkills(ind(range)),zeros(length(ind(range)),1),'gx');
legend('EP','Naive ranking');

fprintf('\n\n');
