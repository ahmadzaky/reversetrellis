function [output] = my_dec2bin(data)

l = length(data);

for i = 1:l
    if data(i) == 0
        output(i,:) = '10000';
    elseif data(i) == 1
        output(i,:) = '10001';
    elseif data(i) == 2
        output(i,:) = '10010';
    elseif data(i) == 3
        output(i,:) = '10011';
    elseif data(i) == 4
        output(i,:) = '10100';
    elseif data(i) == 5
        output(i,:) = '10101';
    elseif data(i) == 6
        output(i,:) = '10110';
    elseif data(i) == 7
        output(i,:) = '10111';
    elseif data(i) == 8
        output(i,:) = '11000';
    elseif data(i) == 9
        output(i,:) = '11001';
    elseif data(i) == 10
        output(i,:) = '11010';
    elseif data(i) == 11
        output(i,:) = '11011';
    elseif data(i) == 12
        output(i,:) = '11100';
    elseif data(i) == 13
        output(i,:) = '11101';
    elseif data(i) == 14
        output(i,:) = '11110';
    elseif data(i) == 15
        output(i,:) = '11111';
    elseif data(i) == 16
        output(i,:) = '00000';
    elseif data(i) == 17
        output(i,:) = '00001';
    elseif data(i) == 18
        output(i,:) = '00010';
    elseif data(i) == 19
        output(i,:) = '00011';
    elseif data(i) == 20
        output(i,:) = '00100';
    elseif data(i) == 21
        output(i,:) = '00101';
    elseif data(i) == 22
        output(i,:) = '00110';
    elseif data(i) == 23
        output(i,:) = '00111';
    elseif data(i) == 24
        output(i,:) = '01000';
    elseif data(i) == 25
        output(i,:) = '01001';
    elseif data(i) == 26
        output(i,:) = '01010';
    elseif data(i) == 27
        output(i,:) = '01011';
    elseif data(i) == 28
        output(i,:) = '01100';
    elseif data(i) == 29
        output(i,:) = '01101';
    elseif data(i) == 30
        output(i,:) = '01110';
    elseif data(i) >= 31
        output(i,:) = '01111';
    end
end