nameImg=strcat('.\Img\14.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
figure, imshow(img_gray,[]);

F= fft2(img_gray);

F2 = fftshift(F);%swap (Top-Left with Bottom-Right) (Top-Right with Bottom-Left)

S=abs(F2); % Get the magnitude


S2 = log(1+S);%para mejorar el rango dinamico de visualizacao
%to expand the range of the dark pixels into the bright region
%so we can better see the transform.
% +1 since log(0) is undefined
figure, imshow(S2,[]);
disp(S2);
