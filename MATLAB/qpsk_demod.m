function [demodulated] = demod_QPSK(data)

l =  length(data);
for i = 0 : (l/2)-1
    if data((i*2)+1) < 0.0 
		if data((i*2)+2) < 0.0
			demodulated((i*2)+1) = 1;
			demodulated((i*2)+2) = 1;
		else
			demodulated((i*2)+1) = 0;
			demodulated((i*2)+2) = 1;
		end
	elseif data((i*2)+1) >= 0.0 
		if data((i*2)+2) >= 0.0
			demodulated((i*2)+1) = 0;
			demodulated((i*2)+2) = 0;
		else
			demodulated((i*2)+1) = 1;
			demodulated((i*2)+2) = 0;
		end
    end
end