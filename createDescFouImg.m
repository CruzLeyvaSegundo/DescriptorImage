
% Author:   
% Date:     
% Partner:  
% Course:   PI
% 
% Function   : createDescFouImg
% 
% Purpose    : Obtain the fourier descriptor of an image
%              for Image analysis, especifically Characterising and recognising the shapes of object
% 
% Parameters : the image in gray_scale AND the index of the image
% 
% Return     : a vector of 401 positions([1]:index [2-401]:descriptor_information )
% 

 
function descriptore = createDescFouImg( Imagem, nroImg ) 
 
img = imresize(Imagem, [400 400]);

% figure, imshow(img,[]);

F= fft2(img);

F2 = fftshift(F);%swap (Top-Left with Bottom-Right) (Top-Right with Bottom-Left)
S=abs(F2); % Get the magnitude

S2 = log(1+S);%para mejorar el rango dinamico de visualizacao
%to expand the range of the dark pixels into the bright region
%so we can better see the transform.
% +1 since log(0) is undefined
% figure, imshow(S2,[]);
[Heigth,Width] = size(S2);%heightxwidth
%disp(S2);
cooX = Width/2;
cooY = Heigth/2;
descriptore(1)=nroImg;
k=2;
range = 10;
for i=cooY-range: cooY+range-1
    for j=cooX-range: cooX+range-1
       descriptore(k) = S2(i,j);
       k = k+1;
    end
end
 
end % function 
