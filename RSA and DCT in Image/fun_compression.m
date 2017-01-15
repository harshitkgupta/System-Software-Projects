
function I=fun_compression(o) 

w = size (o, 2); 
samplesHalf = floor(w / 2); 
samplesQuarter = floor(w / 4);
samplesEighth = floor(w / 8);

ci=[];
ci1=[];
ci2 = [];
ci4 = [];
ci8 = [];

for k=1:3% all color layers: RGB 
for i=1:size(o, 1)% all rows 
ci(i,:,k) = fun_dct(double(o(i,:,k)) );
rowDCT = fun_dct(double(o(i,:,k)));
ci2(i,:,k) = fun_idct(rowDCT(1:samplesHalf), w);
ci4(i,:,k) = fun_idct(rowDCT(1:samplesQuarter), w);
ci8(i,:,k) = fun_idct(rowDCT(1:samplesEighth), w);
end 
end

figure
subplot(1,2,1),imshow(ci);

h = size(o, 1);
samplesHalf = floor(h / 2);
samplesQuarter = floor(h / 4);
samplesEighth = floor(h / 8);
ci2f = [];
ci4f = [];
ci8f = [];
colDCT=[];
colDCT2 = [];
colDCT4 = [];
colDCT8 = [];

for k=1:3% all color layers: RGB 
for i=1:size(o, 2)% all columns 
ci1(i,:,k) = fun_dct(double(ci(i,:,k)));
columnDCT2=fun_dct(double(ci2(:,i,k)));
columnDCT4=fun_dct(double(ci4(:,i,k)));
columnDCT8=fun_dct(double(ci8(:,i,k)));
colDCT(:,i,k)=fun_dct(double(ci(:,i,k)));
colDCT2(:,i,k)=fun_dct(double(ci2(:,i,k)));
colDCT4(:,i,k)=fun_dct(double(ci4(:,i,k)));
colDCT8(:,i,k)=fun_dct(double(ci8(:,i,k)));
ci2f(:,i,k) = fun_idct(columnDCT2(1:samplesHalf), h);
ci4f(:,i,k) = fun_idct(columnDCT4(1:samplesQuarter), h);
ci8f(:,i,k) = fun_idct(columnDCT8(1:samplesEighth), h);
end 
end

subplot(1,2,2),imshow(ci1);
figure
subplot(2,2,1), image(uint8(o)), title('Original Image');
subplot(2,2,2), image(uint8(ci2)), title('Compression Factor 2');
subplot(2,2,3), image(uint8(ci4)), title('Compression Factor 4');
subplot(2,2,4), image(uint8(ci8)), title('Compression Factor 8');
figure
subplot(2,2,1), image(uint8(o)), title('Original Image');
subplot(2,2,2), image(uint8(ci2f)), title('Compression Factor 2 * 2');
subplot(2,2,3), image(uint8(ci4f)), title('Compression Factor 4 * 4');
subplot(2,2,4), image(uint8(ci8f)), title('Compression Factor 8 * 8');
figure
subplot(2,2,1), imhist(rgb2gray(uint8(o))), title('Original Image');
subplot(2,2,2), imhist(rgb2gray(uint8(ci2f))), title('Compression Factor 2 * 2');
subplot(2,2,3), imhist(rgb2gray(uint8(ci4f))), title('Compression Factor 4 * 4');
subplot(2,2,4), imhist(rgb2gray(uint8(ci8f))), title('Compression Factor 8 * 8');

imwrite(uint8(ci2f),'1.jpg');
imwrite(uint8(ci4f),'2.jpg');
imwrite(uint8(ci8f),'3.jpg');

I=uint8(ci2f);