function printTestResults(nrmError, solnError, testName)
	fprintf('TEST %s:\n', testName)
	diff = abs(nrmError - solnError);
	if (diff < 1e-2 | nrmError < solnError )
		fprintf('The performance is adequate and your code may very well be correct.\n');
	else
		fprintf('The performance is inadequate. You may have a bug or you may find\n');
		fprintf('that changing some parameters improves your score.\n\n');
	end
end

