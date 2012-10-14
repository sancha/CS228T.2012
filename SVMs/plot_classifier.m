function plot_classifier(w, problem, line_style)
	w_mat = reshape(w,[problem.D problem.G]);
	colors = ['r+'; 'bo';'m.';'c+';'go';'kx';'y+'];

	x = [];
	%% recover only the correct x
	for k=1:problem.K
		ind = find(problem.data.h == k);
		t = squeeze(problem.data.X(:,k,ind));
		x = [x t];
	end

	max_val = max(x,[],2);
	min_val = min(x,[],2);

	x_range = min_val(1):0.1:max_val(1);
	y_range = min_val(2):0.1:max_val(2);

	for g=1:problem.G
		y_val = -(x_range * w_mat(1,g) + w_mat(3,g))/w_mat(2,g);
		x_val = -(y_range * w_mat(2,g) + w_mat(3,g))/w_mat(1,g);

		hold on;
		plot(x_range, y_val, colors(g), 'Line_width',2, ...
               'Marker_edge_color','k', 'Marker_face_color','g', ...
					'Marker_size',10);
	end
	axis([min_val(1) max_val(1) min_val(2) max_val(2)]);

end


function boydist_plot()
	p_num = []; p_den = [];
	for g=2:problem.G
		p_num = [p_num; (w_mat(1:2,1) - w_mat(1:2,g))'];
		p_den = [p_den; (w_mat(3,1) - w_mat(3,g)) ];
	end

	%% Most confusing point
	p = p_num \ p_den		
	plot(p(1), p(2), 'ko', 'Line_width',2,...
			'Marker_edge_color','k', 'Marker_face_color','g', ...
			'Marker_size',10);
	
	u = zeros(2,problem.G);
	v = zeros(problem.G,1);
	line = zeros(problem.G,length(x_range));
	for g=1:problem.G
		u(:,g) = w_mat(1:2,g) - w_mat(1:2,mod(g,problem.G)+1);
		v(g) =  w_mat(3,g) - w_mat(3,mod(g,problem.G)+1);
		line(g,:) = (x_range * u(1,g) + v(g))/u(2,g);
	end
	
	idx = cell(3);	
	for g=1:problem.G
		g_next = mod(g,problem.G)+1;
		idx{g} = find(u(:,g_next)' * [x_range; line(g,:)] - v(g_next) > 0);
	end
	
	for g=1:problem.G
		hold on;
		plot(x_range(idx{g}),line(g,idx{g}),'k');
	end
	axis([min_val(1) max_val(1) min_val(2) max_val(2)]);

end

