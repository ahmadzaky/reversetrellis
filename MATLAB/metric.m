function distance = metric(x,y,q)

if q == 3
    p = 7;
elseif q == 4
    p = 15;
elseif q == 5
    p = 31;
else
    error('Not supported quantization bits')
end


if y == 1
    distance = (p - x);
else
    distance = (x);
end