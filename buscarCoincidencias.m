%%%%%%%%%%Cargar Base de datos%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP y FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%%
%%Cargando vectores LBP 
fileID = fopen('baseDatosLBP.txt','r');
fileID2 = fopen('baseFourier.txt','r');
nImg=10000;
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
    
%     fprintf('%d ',fourierOrdenado(i,1));
%     fprintf('%8.3f ',fourierOrdenado(i,(2:end)));
%     fprintf('\n');    
end
%%Cargando registro de indexacion LBP
registroIndexLBP=zeros(1,nImg);
registroIndexLBP(1,:)=fscanf(fileID,'%d',nImg);
% fprintf('%d ',registroIndexLBP(i,:));
% fprintf('\n');  
%%Cargando registro de indexacion FOURIER
%     registroIndexFourier=zeros(1,nImg);
%     registroIndexFourier(1,:)=fscanf(fileID2,'%d',nImg);
% fprintf('%d ',registroIndexFourier(i,:));
% fprintf('\n'); 
close(wb);
%%%%%%%%%%%%%%%%%%%%%%%%%%% busqueda %%%%%%%%%%%%%%%%%%%%%%%%%%
img=1;  %Imagen que se utilizara para la query
k=5; %Numero de coincidencias a reportar
wb = waitbar(0,'Buscando coincidencias');
nameImg=strcat('.\Img\',num2str(img),'.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
img_gray=imresize(img_gray, [400 400]);

descriptorLBP=hallarVectorLBP(img_gray); %Tamaño 59, '1:59': lo 59 rotulos
indiceQuery=registroIndexLBP(img);
fprintf('index:  %d\n',indiceQuery)
muestra=4000;
descriptoresMuestra=zeros(muestra,60);
cantActual=1;
anterior=indiceQuery-1;
posterior=indiceQuery+1;
while(cantActual<=muestra)
     waitbar(cantActual/(2*muestra+k), wb);
    if(anterior>=1)
        descriptoresMuestra(cantActual,:)=lbpOrdenado(anterior,:);
        anterior=anterior-1;
        cantActual=cantActual+1;
    end
    if(posterior<=10000)
        descriptoresMuestra(cantActual,:)=lbpOrdenado(posterior,:);
        posterior=posterior+1;
        cantActual=cantActual+1;
    end
end

simLBP=zeros(muestra,2);
for j=1:muestra
    waitbar((cantActual+j)/(2*muestra+k), wb);
    p=descriptoresMuestra(j,(2:end));
    simLBP(j,1)=descriptoresMuestra(j,1);
    simLBP(j,2)=simCoseno(descriptorLBP,p);      
end
ranking=burbuja(simLBP);
nameImg=strcat('.\Img\',num2str(img),'.jpg');
img_Salida = imread(nameImg);
figure,imshow(img_Salida);
salida=zeros(k,60);
for i=1:k
    waitbar((2*muestra+i)/(2*muestra+k), wb);
    salida(i,:)=lbpOrdenado(registroIndexLBP(ranking(muestra-i+1,1)),:);
    nameImg=strcat('.\Img\',num2str(salida(i,1)),'.jpg');
    img_Salida = imread(nameImg);
    figure,imshow(img_Salida);
    fprintf('Imagen %d parecida a %d con similitud %.4f\n',img,salida(i,1),ranking(muestra-i+1,2));
end
close(wb);
% descriptorFourier=createDescFouImg(img_gray);
%%%% Busqueda por tabla de hash  o Implementar Busqueda binaria%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fileID);
fclose(fileID2);