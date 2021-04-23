function r=deci2soft(x)
r=zeros(1,3);

bit2 = x - 4;
if bit2 >= 0 
	x = bit2;
	r(1,3) = 3;
else
	r(1,3) = -4;
end
bit1 = x - 2;
if bit1 >= 0 
	x = bit1;
	r(1,2) = 3;
else
	r(1,2) = -4;
end

if x > 0 
	r(1,1) = 3;
else
	r(1,1) = -4;
end

	