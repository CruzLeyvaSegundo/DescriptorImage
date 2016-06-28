% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 08, 2016  
%
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
function descriptore = createDescFouImg( ImagemGray ) 
[n m]=size(ImagemGray); 
img = imresize(ImagemGray,[400 400]);
% if(n~=300)
%    img=ImagemGray';
% end
%tresholding image

img = im2bw(img,0.5);
figure, imshow(img,[]);;
F= fft2(img);

F2 = fftshift(F);%swap (Top-Left with Bottom-Right) (Top-Right with Bottom-Left)
S=abs(F2); % Get the magnitude


%para mejorar el rango dinamico de visualizacao
%to expand the range of the dark pixels into the bright region
%so we can better see the transform.
% +1 since log(0) is undefined
S2 = log(1+S);
% figure, imshow(S2,[]);
[Heigth,Width] = size(S2);%heightxwidth
%disp(S2);
cooX = (Width/2)+1;
cooY = (Heigth/2)+1;

vec = zeros(Heigth);
for i=1:Heigth
      vec(1,i)=max(max(S2(i,:)));
end
maxValue = max(max(vec));

descriptore=zeros(1,400);
k=1;
range = 10;
for i=cooY-range: cooY+range-1
    for j=cooX-range: cooX+range-1
       descriptore(k) =(S2(i,j)*(255/maxValue));
       k = k+1;
    end
end
 
end % function 





