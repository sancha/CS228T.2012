function plotData(numGaussians,X,y,titleStr,reuseFigure)
	colors = ['r+'; 'bo';'m.';'c+';'go';'kx';'y+'];
   if ~exist('reuseFigure')
		figure;
		hold on;
	else
		clf;
		hold on;
	end
	
	title(titleStr);
	unq_y = unique(y);
	for s=1:numGaussians
		ind = find(y==unq_y(s));
		plot(X(ind,1),X(ind,2),colors(mod(s-1,size(colors,1))+1,:));
	end
end
