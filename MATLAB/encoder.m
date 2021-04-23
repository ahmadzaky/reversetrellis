function [encoded] = encoder_convo(data)

l =  length(data);
buff = data;

for i = 0 : (l-6)
	encoded(3*i)	 = buff(6) xor buff(4) xor buff(3) xor buff(1) xor buff(0);
	encoded((3*i)+1) = buff(6) xor buff(5) xor buff(4) xor buff(3) xor buff(0);
	encoded((3*i)+2) = buff(6) xor buff(5) xor buff(4) xor buff(2) xor buff(0);
	temp = buff(1);
	for j=1:(l-1)
			buff(j) = buff(j+1);
		end
	buff(l) = temp;
end

