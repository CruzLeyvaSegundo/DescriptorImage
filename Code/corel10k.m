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
wb = waitbar(0,'Carregando banco de dados (imagens Descritores)');
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
bandEntrada=true;
while(bandEntrada)
    %corel10k 200.jpg 5 fourier
    fprintf('\n$');
    cadEntrada=input(' ','s');
    if(cadEntrada=='q')
        bandEntrada=false;
    else
        cadEntrada=textscan(cadEntrada, '%s', 'delimiter', ' ');
        entrada=cellstr(cadEntrada{1});
        [minP l]=size(entrada);
        
        img=str2double(entrada(1));%Imagen que se utilizara para la query
        img=round(img);
        r=2;
        if(minP==2)
            k=5; 
        elseif(minP==3)
        k=str2double(entrada(r));%Numero de coincidencias a reportar
        k=round(k);
        r=r+1;
        end
        if(strcmpi((entrada(r)),'fourier')==1)%Descriptor escogido - Si op=1 entonces se usa fourier Sino se utiliza LBP
            op=1;
        elseif(strcmpi((entrada(r)),'lbp')==1)
            op=2;
        end
        muestra=4000; %Tamano de muestra a analizar
        nameImg=strcat('..\Img\',num2str(img),'.jpg');
        img_RGB = imread(nameImg);
        img_gray=rgb2gray(img_RGB);
        [n m]=size(img_gray);               
        if(op==1) %%FOURIER
            img_gray = imresize(img_gray,[400 400]);
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
        wb = waitbar(0,'Obtenção de imagens de amostra');
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

        wb = waitbar(0,'Calculando semelhança da consulta com amostras');
        simLBP=zeros(muestra,2);
        for j=1:muestra
            waitbar(j/muestra, wb);
            p=descriptoresMuestra(j,(2:end));
            simLBP(j,1)=descriptoresMuestra(j,1);
            if(op==1)%fourier
                simLBP(j,2)=distEuclidiana(descriptorQuery,p);  
            elseif(op==2)%%LBP
                simLBP(j,2)=simCoseno(descriptorQuery,p);      
            end
        end
        close(wb);

        %ranking=burbuja(simLBP);
        ranking=heapsort(simLBP);

        nameImg=strcat('..\Img\',num2str(img),'.jpg');
        img_Salida = imread(nameImg);
        figure,imshow(img_Salida),title('QUERY');
        salida=zeros(k,nRotulo);
        for i=1:k
            if(op==1)%fourier
                salida(i,:)=descriptoresOrdenados(registroIndex(ranking(i,1)),:);
                fprintf('Imagem %d semelhante a %d como similaridade %.4f\n',img,salida(i,1),ranking(i,2));
            elseif(op==2)%%LBP
                salida(i,:)=descriptoresOrdenados(registroIndex(ranking(muestra-i+1,1)),:);   
                fprintf('Imagem %d semelhante a %d como similaridade %.4f\n',img,salida(i,1),ranking(muestra-i+1,2));
            end
            nameImg=strcat('..\Img\',num2str(salida(i,1)),'.jpg');
            img_Salida = imread(nameImg);
            figure,imshow(img_Salida),title(strcat('k-esimo: ',num2str(i)));
        end
    end
end
fclose(fileID);
fclose(fileID2);