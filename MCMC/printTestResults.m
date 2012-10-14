function printTestResults(nrmError, solnError, maxAllowedError, testName)
	diff = abs(nrmError - solnError);
	if (diff < 1e-2)
		fprintf('You got exactly our score. Good job!');
	elseif (nrmError < maxAllowedError)
		fprintf('Your performace is adequate, but your score differs from ours\n'); 
		fprintf('This may be numerical and requires review by a grader.')
	else
		fprintf('The performance is inadequate, and you almost definitely have an error.');
	end
	fprintf('\n');
end

