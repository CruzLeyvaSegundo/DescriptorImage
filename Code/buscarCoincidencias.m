% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 16, 2016  
%
% Course:   PI
% 
% Purpose    : K find the images more similar to a query using a method descriptor
% 
% Parameters : nothing
% 
% Return     : nothing

%%%%%%%%%%Cargar Base de datos%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP y FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%%
%Obtener el Path de la carpeta Actual
fileID = fopen('..\BaseDados\baseDatosLBP.txt','r');
fileID2 = fopen('..\BaseDados\baseFourier.txt','r');
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
%%Cargando registro de indexacion FOURIER
registroIndexFourier=zeros(1,nImg);
registroIndexFourier(1,:)=fscanf(fileID2,'%d',nImg);
close(wb);
%%%%%%%%%%%%%%%%%%%%%%%%%%% busqueda %%%%%%%%%%%%%%%%%%%%%%%%%%
img=3655;  %Imagen que se utilizara para la query
k=5; %Numero de coincidencias a reportar
op=1; %Descriptor escogido - Si op=1 entonces se usa fourier Sino se utiliza LBP
muestra=4000; %Tamano de muestra a analizar
nameImg=strcat(strcat('..\Img\',num2str(img),'.jpg'));
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
[n m]=size(img_gray);
if(n~=300)
    img_gray=img_gray';
end
if(op==1) %%FOURIER
    descriptorQuery=createDescFouImg(img_gray); %Tamaño 401,'1': nombreImg '2:401': los 400 puntos del espectro tomados    
    registroIndex=registroIndexFourier;
    indiceQuery=registroIndexFourier(img);
    descriptoresOrdenados=fourierOrdenado;
    nRotulo=401;
elseif(op==2)%%LBP
    descriptorQuery=hallarVectorLBP(img_gray); %Tamaño 60,'1': nombreImg '2:60': lo 59 rotulos
    registroIndex=registroIndexLBP;
    indiceQuery=registroIndexLBP(img);
    descriptoresOrdenados=lbpOrdenado;
    nRotulo=60;
end
fprintf('index:  %d\n',indiceQuery)

descriptoresMuestra=zeros(muestra,nRotulo);
cantActual=1;
anterior=indiceQuery-1;
posterior=indiceQuery+1;
wb = waitbar(0,'Obteniendo muestra de imagenes');
while(cantActual<=muestra)
     waitbar(cantActual/muestra, wb);
    if(anterior>=1&&cantActual<=muestra)
        descriptoresMuestra(cantActual,:)=descriptoresOrdenados(anterior,:);
        anterior=anterior-1;
        cantActual=cantActual+1;
    end
    if(posterior<=10000&&cantActual<=muestra)
        descriptoresMuestra(cantActual,:)=descriptoresOrdenados(posterior,:);
        posterior=posterior+1;
        cantActual=cantActual+1;
    end
end
close(wb);

wb = waitbar(0,'Calculando similaridad de la query con las muestras');
simLBP=zeros(muestra,2);
for j=1:muestra
    waitbar(j/muestra, wb);
    p=descriptoresMuestra(j,(2:end));
    simLBP(j,1)=descriptoresMuestra(j,1);
    simLBP(j,2)=simCoseno(descriptorQuery,p);      
end
close(wb);

%ranking=burbuja(simLBP);
ranking=heapsort(simLBP);

nameImg=strcat('..\Img\',num2str(img),'.jpg');
img_Salida = imread(nameImg);
figure,imshow(img_Salida),title('QUERY');
salida=zeros(k,nRotulo);
for i=1:k
    salida(i,:)=descriptoresOrdenados(registroIndex(ranking(muestra-i+1,1)),:);
    nameImg=strcat('..\Img\',num2str(salida(i,1)),'.jpg');
    img_Salida = imread(nameImg);
    figure,imshow(img_Salida),title(strcat('k-esimo: ',num2str(i)));
    fprintf('Imagen %d parecida a %d con similitud %.4f\n',img,salida(i,1),ranking(muestra-i+1,2));
end
fclose(fileID);
fclose(fileID2);