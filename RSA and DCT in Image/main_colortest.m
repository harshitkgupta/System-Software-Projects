clear all;
close all;
format compact;
clc;

o=imread('download.jpg');


                %# Load an RGB image
%[img1,map] = rgb2ind(I,64);            %# Create your quantized image
%R = reshape(map(img1+1,1),size(img1));  %# Red color plane for image
%G = reshape(map(img1+1,2),size(img1));  %# Green color plane for image
%B = reshape(map(img1+1,3),size(img1));  %# Blue color plane for image

I1=fun_compression(o);
I=imresize(I1,0.10);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
figure
subplot(3,4,1);
imshow(I);
title('original image');

subplot(3,4,2);
imshow(R);
title('red component');

subplot(3,4,4);
imshow(B);
title('blue component');

subplot(3,4,3);
imshow(G);
title('green component');

[ER,DR]=fun_rsa(R);

subplot(3,4,6);
imshow(ER);
title('encrypted red');
subplot(3,4,10);
imshow(DR);
title('decrypted red');

[EG,DG]=fun_rsa(G);
subplot(3,4,7);
imshow(EG);
title('encrypted green');
subplot(3,4,11);
imshow(DG);
title('decrypted green');
[EB,DB]=fun_rsa(B);
subplot(3,4,8);
imshow(EB);
title('encrypted blue');
subplot(3,4,12);
imshow(DB);
title('decrypted blue');

ERGB=cat(3,ER,EG,EB);
subplot(3,4,5);
imshow(ERGB);
title('merged encrypted ');

DRGB=cat(3,DR,DG,DB);
subplot(3,4,9);
imshow(DRGB);
title('merged decrypted ');

figure
subplot(2,2,1);
imhist(rgb2gray(I));
title('original image');

subplot(2,2,2);
imhist(R);
title('red component');

subplot(2,2,3);
imhist(B);
title('blue component');

subplot(2,2,4);
imhist(G);
title('green component');

Rerr=R-DR;
Berr=B-DB;
Gerr=G-DG;
Ierr=I-DRGB;


R1 = o(:,:,1);
G1 = o(:,:,2);
B1 = o(:,:,3);

R2 = I1(:,:,1);
G2 = I1(:,:,2);
B2 = I1(:,:,3);

dR = int32(R1) - int32(R2);
dG = int32(G1) - int32(G2);
dB = int32(B1) - int32(B2);

errR = sum(abs(dR(:))) % 32bits sufficient for sum of 256x256 uint8 img.
errG = sum(abs(dG(:)))
errB = sum(abs(dB(:)))

mseR = mean(dR(:).^2)
mseG = mean(dG(:).^2)
mseB = mean(dB(:).^2) 



D = abs(double(o)-double(I1)).^2;
mse  = sum(D(:))/numel(I)


psnr = 10*log10(255*255/mse)


differenceImage = abs(double(o) - double(I1));
stdDeviation = std2(differenceImage(:));