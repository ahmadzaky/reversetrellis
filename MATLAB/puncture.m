function [data_pun] = puncture(data_conv, rate);
% the puncturing block, data_conv is the binary data after puncturing
% there are 3 kind of rates which is selected by the rate
p1 = length(data_conv);
if rate == 1 % rate 1/2
    data_pun = data_conv;
elseif rate == 2 % rate 2/3
    if rem(p1, 4) == 0
        p2 = p1/4;
        for i = 1: p2
            data_pun(1 + (i-1)*3) = data_conv(1 + (i-1)*4);
            data_pun(2 + (i-1)*3) = data_conv(2 + (i-1)*4);
            data_pun(3 + (i-1)*3) = data_conv(3 + (i-1)*4);
        end
    else p4 = (p1 - rem(p1, 4))/4;
        p5 = rem(p1, 4);
        for i = 1: p4
            data_pun(1 + (i-1)*3) = data_conv(1 + (i-1)*4);
            data_pun(2 + (i-1)*3) = data_conv(2 + (i-1)*4);
            data_pun(3 + (i-1)*3) = data_conv(3 + (i-1)*4);
        end
        for i = 1 : p5
            data_pun(3*p4 + i)= data_conv(p1 -p5 +i);
        end
    end
elseif rate == 3 % rate 3/4
    if rem(p1, 6) == 0
        p3 = p1/6;
        for i = 1: p3
            data_pun(1 + (i-1)*4) = data_conv(1 + (i-1)*6);
            data_pun(2 + (i-1)*4) = data_conv(2 + (i-1)*6);
            data_pun(3 + (i-1)*4) = data_conv(3 + (i-1)*6);
            data_pun(4 + (i-1)*4) = data_conv(6 + (i-1)*6);
        end
    else p4 = (p1 - rem(p1, 6))/6;
        p5 = rem(p1, 6);
        for i = 1: p4
            data_pun(1 + (i-1)*4) = data_conv(1 + (i-1)*6);
            data_pun(2 + (i-1)*4) = data_conv(2 + (i-1)*6);
            data_pun(3 + (i-1)*4) = data_conv(3 + (i-1)*6);
            data_pun(4 + (i-1)*4) = data_conv(6 + (i-1)*6);
        end
        for i = 1 : p5
            data_pun(4*p4 + i)= data_conv(p1 - p5 + i);
        end
    end
else error('The setup of rate is out of range!!!')
end