%OBTAIN THE DFT OF AN IMAGE V1
nameImg=strcat('.\Img\8.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
F= fft2(img_gray);

F2 = fftshift(F);%swap (Top-Left with Bottom-Right) (Top-Right with Bottom-Left)

S=abs(F2); % Get the magnitude
imshow(S,[]);

S2 = log(1+S);%para mejorar el rango dinamico de visualizacao
%to expand the range of the dark pixels into the bright region
%so we can better see the transform.
% +1 since log(0) is undefined
imshow(S2,[]);
%====================================================
%OBTAIN THE DFT OF AN IMAGE V2
nameImg=strcat('.\Img\10.jpg');
img = imread(nameImg);
imagesc(img)
%img   = fftshift(img(:,:,2));
F     = fft2(img);

figure;

imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('magnitude spectrum');

figure;
imagesc(angle(F));  colormap(gray);
title('phase spectrum');
