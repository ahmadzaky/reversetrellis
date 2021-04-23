function [modulated] = QPSK(data)

l =  length(data);
for i = 0 : (l/2)-1
    if data((i*2)+1) == 0  
		if data((i*2)+2) == 0
			modulated((i*2)+1) = 0.707;
			modulated((i*2)+2) = 0.707;
		else
			modulated((i*2)+1) = -0.707;
			modulated((i*2)+2) = 0.707;
		end	
	elseif data((i*2)+1) == 1 
		if data((i*2)+2) == 1
			modulated((i*2)+1) = -0.707;
			modulated((i*2)+2) = -0.707;
		else
			modulated((i*2)+1) = 0.707;
			modulated((i*2)+2) = -0.707;
		end
    end
end
