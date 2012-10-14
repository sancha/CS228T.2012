classdef Message
	properties
		P %% Precision 
		h %% Potential 
	end

	methods
		function msg = Message(P,h)
			msg.P = P;
			msg.h = h;
		end
	end
end

