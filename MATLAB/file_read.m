function [data] = file_read(file)

fid = fopen(file);
i = 1;
while 1
    tline = fgetl(fid);
    if ~ ischar(tline)
        break
    elseif tline == '1'
        data(i) = 1;
    else
        data(i) = 0;
    end
    i = i+1;
end
fclose(fid);