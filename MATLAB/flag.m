function [pun]= flag(data_soft_de, rate);
% generate the flag for Viterbi decoder dealing with the dummy zeros
l = length(data_soft_de);
if rate == 1
    for i=1:l
        pun(l) = 0;
    end
elseif rate == 2
    for i=1:l
        if rem (i, 4) == 0
            pun(i)=1;
        else pun(i)=0;
        end
    end
elseif rate == 3
    t1 = (l-rem(l,6))/6;
    for i=0:t1-1
        pun(6*(i)+1)=0;
        pun(6*(i)+2)=0;
        pun(6*(i)+3)=1;
        pun(6*(i)+4)=0;
        pun(6*(i)+5)=1;
        pun(6*(i)+6)=0;
    end
    for j =( l - rem(l,6) ):l
        pun(j)=0;
    end
end
