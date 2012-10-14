function printTestResults(nrmError, solnError, maxAllowedError, testName)
	fprintf ('\n%s\n',testName);
	if (strcmp(testName, 'HDP-LDA') == 0)
		fprintf ('Your code is almost certainly wrong, unless you really understand the');
		fprintf (' paper and are sure that your code is correct.\n');
		return;
	end

	fprintf ('\nNorm error : %f \nMaximum allowed error : %f \n', nrmError, maxAllowedError);
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
