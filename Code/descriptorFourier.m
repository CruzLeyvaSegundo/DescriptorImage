% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 14, 2016  
%      
% Course:   Processamento de Imagens 
% 
% Function   : descriptorFourier
% 
% Purpose    : creates the file "baseFourier.txt" that contains the Fourier Descriptors of 10k images
% 
% Parameters : nothing
% 
% Return     : nothing
function descriptorFourier( ) 
    fileID = fopen('..\BaseDados\baseFourier.txt','wt');
    nImg=10000;
    fourier_descriptors=zeros(nImg,400);
    DescFurierNormalizado=zeros(nImg,400);
    wb = waitbar(0,'Creando base de datos(Descriptores de imagenes)');
    for k=1:nImg
        waitbar(k/nImg, wb);
        nameImg=strcat('..\Img\',num2str(k),'.jpg');
        img_RGB = imread(nameImg);
        img_gray=rgb2gray(img_RGB);
        descFurier= createDescFouImg(img_gray);
        fourier_descriptors(k,:)=descFurier;  
        DescFurierNormalizado(k,:)=descFurier./norm(descFurier);
    end
    close(wb);
    simCosenoFurier=zeros(nImg,2); % nombre y simulitud con la query son guardados aca
    %lbpOrdenado Aca se almacena el ranking de los descritores con respecto a la query
    query=ones(1,400);
    query=query./norm(query);
    wb = waitbar(0,'Calculando similaridad entre los descriptores');
    %Calculo de la similitud de coseno de los vectores con respecto a una qeury
    for i=1:nImg
        waitbar(i/nImg, wb);
        simCosenoFurier(i,1)=i;
        simCosenoFurier(i,2)=simCoseno(query,DescFurierNormalizado(i,:));
    end
    close(wb);
%     fprintf('+++++++++++++++++++++++++++\n');
    %Se ordenan los ranking
    FurierOrdenado=crearRanking(simCosenoFurier,fourier_descriptors,2);
    
    wb = waitbar(0,'Guardando ranking Furier...');
    registroIndex=zeros(1,nImg);
    %SE GUARDA EL RANKING DE LOS VECTORES LBP
    for i=1:nImg
        waitbar(i/nImg, wb);
        registroIndex(FurierOrdenado(i,1))=i;
        fprintf(fileID,'%d ',FurierOrdenado(i,1));
        fprintf(fileID,'%8.3f ',FurierOrdenado(i,(2:end)));
        fprintf(fileID,'\n');
    end
    %SE GUARDA EL REGISTRO DE INDEXACION DE LOS VECTORES LBP 
    fprintf(fileID,'%d ',registroIndex(1,:));
    %verificarRanking(FurierOrdenado);
   close(wb);
   fclose(fileID);
end
