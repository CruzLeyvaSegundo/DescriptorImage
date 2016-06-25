nameImg=strcat('..\Img\2.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
img = imresize(img_gray, [400 400]);

% figure, imshow(img,[]);

F= fft2(img);

F2 = fftshift(F);%swap (Top-Left with Bottom-Right) (Top-Right with Bottom-Left)

S=abs(F2); % Get the magnitude


S2 = log(1+S);%para mejorar el rango dinamico de visualizacao
%to expand the range of the dark pixels into the bright region
%so we can better see the transform.
% +1 since log(0) is undefined
figure, imshow(S2,[]);
[Heigth,Width] = size(S2);%heightxwidth
%disp(S2);
cooX = Width/2;
cooY = Heigth/2;
descriptore = [];
k=1;
range = 10;
for i=cooY-range: cooY+range-1
    for j=cooX-range: cooX+range-1
      disp(i);
      disp(j);
       descriptore(k) = S2(i,j);
       k = k+1;
    end

end
% disp(descriptore);
disp(size(descriptore));