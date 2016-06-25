% Author:   
% Date:     
% Partner:  
% Course:   
% 
% Function   : Name of Function 
% 
% Purpose    : What task does the function accomplish 
%              or what does it compute 
% 
% Parameters : What values/types are expected as input? 
% 
% Return     : What comes out of the function?  

  
function descFouri( ) 
    fileID = fopen('baseFourier.txt','wt');
    nImg=5;
    fourier_descriptors=[];
    wb = waitbar(0,'Creando base de datos(Descriptores de imagenes)');

    for k=1:nImg
        waitbar(k/nImg, wb);
        nameImg=strcat('..\Img\',num2str(k),'.jpg');
        img_RGB = imread(nameImg);
        img_gray=rgb2gray(img_RGB);
        fourier_descriptors  = [fourier_descriptors; createDescFouImg(img_gray,k)];

    end
    %disp(fourier_descriptors);
    [m,n] = size(fourier_descriptors);
    for i=1:m
        for j=1:n
           fprintf(fileID,'%.4f ',fourier_descriptors(i,j));
        end
    end
   close(wb);
   fclose(fileID);
end

