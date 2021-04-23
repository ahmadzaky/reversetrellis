function [modulated] = bpsk_mod(data)

l =  length(data);
for i = 1 : l
    if data(i) == 0
        modulated(i) = -1;
    else modulated(i) = 1;
    end
end
