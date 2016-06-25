%%%%%%%%%%Cargar Base de datos%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP y FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%%
%%Cargando vectores LBP 
fileID = fopen('baseDatosLBP.txt','r');
fileID2 = fopen('baseFourier.txt','r');
nImg=20;
lbpOrdenado=zeros(nImg,60);
fourierOrdenado=zeros(nImg,401);
wb = waitbar(0,'Cargando base de datos(Descriptores de imagenes)');
for i=1:nImg
    waitbar(i/nImg, wb);
    %%LBP
    img=fscanf(fileID,'%d',1);
    lbpOrdenado(i,1)=img;
    lbpOrdenado(i,(2:end))=fscanf(fileID,'%d',59);
    %%FOURIER
    img=fscanf(fileID2,'%d',1);
    fourierOrdenado(i,1)=img;
    fourierOrdenado(i,(2:end))=fscanf(fileID2,'%f',400);
    
    fprintf('%d ',fourierOrdenado(i,1));
    fprintf('%8.3f ',fourierOrdenado(i,(2:end)));
    fprintf('\n');    
end
%%Cargando registro de indexacion LBP
registroIndexLBP=zeros(1,nImg);
registroIndexLBP(i,:)=fscanf(fileID,'%d',nImg);
% fprintf('%d ',registroIndexLBP(i,:));
% fprintf('\n');  
%%Cargando registro de indexacion FOURIER
registroIndexFourier=zeros(1,nImg);
registroIndexFourier(i,:)=fscanf(fileID2,'%d',nImg);
fprintf('%d ',registroIndexFourier(i,:));
fprintf('\n'); 
close(wb);
%%%%%%%%%%%%%%%%%%%%%%%%%%% busqueda %%%%%%%%%%%%%%%%%%%%%%%%%%
img=1;  %Imagen que se utilizara para la query
k=5; %Numero de coincidencias a reportar
nameImg=strcat('.\Img\',num2str(img),'.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
img_gray=imresize(img_gray, [400 400]);
descriptorLBP=hallarVectorLBP(img_gray); %Tamaño 59, '1:59': lo 59 rotulos
descriptorFourier=createDescFouImg(img_gray);
%%%% Busqueda por tabla de hash  o Implementar Busqueda binaria%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fileID);
fclose(fileID2);