rawimg = imread('Penguins.bmp');
grayim  = rgb2gray(rawimg);
%imshow(grayim);
bitstream(1:38988) = reshape(grayim,38988,1);
bitstream(38989:39000) = [000000000];
resbit = reshape(bitstream,7800,5);
for k=1:7800
for i=1:5
	bitimg(k,((((i-1)*8)+1):(i*8))) = deci2bin(resbit(k,i),8);
end


end
for k=1:7800
for i=1:5
	decimg(k,i) = bin2deci(bitimg(k,((((i-1)*8)+1):(i*8))));
end
end
imgback_1 = reshape(decimg,39000,1);
imgback	  = reshape(imgback_1(1:38988),171,228);
imshow(uint8(imgback));