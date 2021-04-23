function [data_dec] = bpsk_demod(temp2,hard_soft,q)

l = length(temp2);

if hard_soft == 0 %hard decision
    for i = 1 : l
        if temp2(i) <= 0
            data_dec(i) = 0 ;
        else data_dec(i) = 1;
        end
    end
elseif hard_soft == 1 % soft decision
    if q == 3 %3 bit
        for i = 1 : l
            if temp2(i) < -0.8571
                data_dec(i) = 0;
            elseif temp2(i) < -0.5714
                data_dec(i) = 1;
            elseif temp2(i) < -0.2857
                data_dec(i) = 2;
            elseif temp2(i) < 0
                data_dec(i) = 3;
            elseif temp2(i) < 0.2857
                data_dec(i) = 4;
            elseif temp2(i) < 0.5714
                data_dec(i) = 5;
            elseif temp2(i) < 0.8571
                data_dec(i) = 6;
            elseif temp2(i) >= 0.8571
                data_dec(i) = 7;
            end
        end
    elseif q == 4
        for i = 1 : l
            if temp2(i) < -0.875
                data_dec(i) = 0;
            elseif temp2(i) < -0.75
                data_dec(i) = 1;
            elseif temp2(i) < -0.625
                data_dec(i) = 2;
            elseif temp2(i) < -0.5
                data_dec(i) = 3;
            elseif temp2(i) < -0.375
                data_dec(i) = 4;
            elseif temp2(i) < -0.25
                data_dec(i) = 5;
            elseif temp2(i) < -0.125
                data_dec(i) = 6;
            elseif temp2(i) < 0
                data_dec(i) = 7;
            elseif temp2(i) < 0.125
                data_dec(i) = 8;
            elseif temp2(i) < 0.25
                data_dec(i) = 9;
            elseif temp2(i) < 0.375
                data_dec(i) = 10;
            elseif temp2(i) < 0.5
                data_dec(i) = 11;
            elseif temp2(i) < 0.625
                data_dec(i) = 12;
            elseif temp2(i) < 0.75
                data_dec(i) = 13;
            elseif temp2(i) < 0.875
                data_dec(i) = 14;
            elseif temp2(i) >= 0.875
                data_dec(i) = 15;
            end
        end
    elseif q == 5
        for i = 1 : l
            if temp2(i) < -0.9375
                data_dec(i) = 0;
            elseif temp2(i) < -0.875
                data_dec(i) = 1;
            elseif temp2(i) < -0.8125
                data_dec(i) = 2;
            elseif temp2(i) < -0.75
                data_dec(i) = 3;
            elseif temp2(i) < -0.6875
                data_dec(i) = 4;
            elseif temp2(i) < -0.625
                data_dec(i) = 5;
            elseif temp2(i) < -0.5625
                data_dec(i) = 6;
            elseif temp2(i) < -0.5
                data_dec(i) = 7;
            elseif temp2(i) < -0.4375
                data_dec(i) = 8;
            elseif temp2(i) < -0.375
                data_dec(i) = 9;
            elseif temp2(i) < -0.3125
                data_dec(i) = 10;
            elseif temp2(i) < -0.25
                data_dec(i) = 11;
            elseif temp2(i) < -0.1875
                data_dec(i) = 12;
            elseif temp2(i) < -0.125
                data_dec(i) = 13;
            elseif temp2(i) < -0.0625
                data_dec(i) = 14;
            elseif temp2(i) < 0
                data_dec(i) = 15;
            elseif temp2(i) < 0.0625
                data_dec(i) = 16;
            elseif temp2(i) < 0.125
                data_dec(i) = 17;
            elseif temp2(i) < 0.1875
                data_dec(i) = 18;
            elseif temp2(i) < 0.25
                data_dec(i) = 19;
            elseif temp2(i) < 0.3125
                data_dec(i) = 20;
            elseif temp2(i) < 0.375
                data_dec(i) = 21;
            elseif temp2(i) < 0.4375
                data_dec(i) = 22;
            elseif temp2(i) < 0.5
                data_dec(i) = 23;
            elseif temp2(i) < 0.5625
                data_dec(i) = 24;
            elseif temp2(i) < 0.625
                data_dec(i) = 25;
            elseif temp2(i) < 0.6875
                data_dec(i) = 26;
            elseif temp2(i) < 0.75
                data_dec(i) = 27;
            elseif temp2(i) < 0.8125
                data_dec(i) = 28;
            elseif temp2(i) < 0.875
                data_dec(i) = 29;
            elseif temp2(i) < 0.9375
                data_dec(i) = 30;
            elseif temp2(i) >= 0.9375
                data_dec(i) = 31;
            end
        end
    else
        error('Not supported quantization bit')
    end
end
