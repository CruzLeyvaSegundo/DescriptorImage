% Author:   
% Date:     
% Partner:  
% Course:   
% 
% Function   : descriptorFourier
% 
% Purpose    : creates the file "baseFourier.txt" that contains the Fourier Descriptors of 10k images
% 
% Parameters : nothing
% 
% Return     : nothing

  
function descriptorFourier( ) 
    fileID = fopen('baseFourier.txt','wt');
    nImg=20;
    fourier_descriptors=zeros(nImg,400);
    DescFurierNormalizado=zeros(nImg,400);
    wb = waitbar(0,'Creando base de datos(Descriptores de imagenes)');
    for k=1:nImg
        waitbar(k/nImg, wb);
        nameImg=strcat('.\Img\',num2str(k),'.jpg');
        img_RGB = imread(nameImg);
        img_gray=rgb2gray(img_RGB);
        descFurier= createDescFouImg(img_gray);
        fourier_descriptors(k,:)=descFurier;
%         fprintf(fileID,'%d ',k); 
%         fprintf(fileID,'%.4f ',descFurier);
%         fprintf(fileID,'\n');     
        DescFurierNormalizado(k,:)=descFurier./norm(descFurier);
    end
    simCosenoFurier=zeros(nImg,2); % nombre y simulitud con la query son guardados aca
    %lbpOrdenado Aca se almacena el ranking de los descritores con respecto a la query
    query=ones(1,400);
    query=query./norm(query);
    %Calculo de la similitud de coseno de los vectores con respecto a una qeury
    for i=1:nImg
        simCosenoFurier(i,1)=i;
        simCosenoFurier(i,2)=simCoseno(query,DescFurierNormalizado(i,:));
        fprintf('%8.3f ',simCosenoFurier(i,:));
        fprintf('\n');
    end
    fprintf('+++++++++++++++++++++++++++\n');
    %Se ordenan los ranking
    FurierOrdenado=crearRanking(simCosenoFurier,fourier_descriptors);
    simCosenoFurier=burbuja(simCosenoFurier);
    registroIndex=zeros(1,nImg);
    %SE GUARDA EL RANKING DE LOS VECTORES LBP
    for i=1:nImg
        fprintf('%8.3f ',simCosenoFurier(end-i+1,:));
        fprintf('\n');
        registroIndex(FurierOrdenado(i,1))=i;
        fprintf(fileID,'%d ',FurierOrdenado(i,1));
        fprintf(fileID,'%8.3f ',FurierOrdenado(i,(2:end)));
        fprintf(fileID,'\n');
    end
    %SE GUARDA EL REGISTRO DE INDEXACION DE LOS VECTORES LBP 
    fprintf(fileID,'%d ',registroIndex(1,:));
    fprintf('\n');
    verificarRanking(FurierOrdenado);
   close(wb);
   fclose(fileID);
end

