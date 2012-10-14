function plot_data(num_gaussians,X,y,title_str,reuse_figure)
	colors = ['r+'; 'bo';'m.';'c+';'go';'kx';'y+'];
   if ~exist('reuse_figure')
		figure;
		hold on;
	else
		clf;
		hold on;
	end
	
	title(title_str);
	for s=1:num_gaussians
		ind = find(y==s);
		plot(squeeze(X(1,1,ind)),squeeze(X(2,1,ind)),colors(mod(s-1,size(colors,1))+1,:));
	end
end
