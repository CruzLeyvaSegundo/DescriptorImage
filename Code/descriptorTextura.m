% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 12, 2016  
%  
% Course:   Processamento de Imagens 
% 
% Function   : descriptorTextura
% 
% Purpose    : creates the file "baseDatosLBP.txt" that contains the LBP Descriptors of 10k images
% 
% Parameters : nothing
% 
% Return     : nothing
function descriptorTextura( ) 
    fileID = fopen('..\BaseDados\baseDatosLBP.txt','wt');
    nImg=10000;
    lbpOriginal=zeros(nImg,59);
    lbpNormalizado=zeros(nImg,59);
    wb = waitbar(0,'Criação de banco de dados (imagens Descritores)');
    for k=1:nImg
        waitbar(k/nImg, wb);
        nameImg=strcat('..\Img\',num2str(k),'.jpg');
        img_RGB = imread(nameImg);
        img_gray=rgb2gray(img_RGB);
        descriptorLBP=hallarVectorLBP(img_gray); %Tamaño 59, '1:59': lo 59 rotulos
        lbpOriginal(k,:)=descriptorLBP;
        lbpNormalizado(k,:)=descriptorLBP./norm(descriptorLBP);
    end
    close(wb);
    simCosenoLBP=zeros(nImg,2); % nombre y simulitud con la query son guardados aca
    %lbpOrdenado Aca se almacena el ranking de los descritores con respecto a la query
    query=ones(1,59);
    query=query./norm(query);
    wb = waitbar(0,'Calculando semelhança entre descritores');
    %Calculo de la similitud de coseno de los vectores con respecto a una qeury
    for i=1:nImg
        waitbar(i/nImg, wb);
        simCosenoLBP(i,1)=i;
        simCosenoLBP(i,2)=simCoseno(query,lbpNormalizado(i,:));
    end
    close(wb);
%     fprintf('+++++++++++++++++++++++++++\n');
    %Se ordenan los ranking
    lbpOrdenado=crearRanking(simCosenoLBP,lbpOriginal,1);
    
    wb = waitbar(0,'Salvando classificação LBP...');
    registroIndex=zeros(1,nImg);
    %SE GUARDA EL RANKING DE LOS VECTORES LBP
    for i=1:nImg
        waitbar(i/nImg, wb);
        registroIndex(lbpOrdenado(i,1))=i;
        fprintf(fileID,'%d ',lbpOrdenado(i,1));
        fprintf(fileID,'%d ',lbpOrdenado(i,(2:end)));
        fprintf(fileID,'\n');
    end
    close(wb);
    %SE GUARDA EL REGISTRO DE INDEXACION DE LOS VECTORES LBP 
    fprintf(fileID,'%d ',registroIndex(1,:));
    fprintf('\n');
    verificarRanking(lbpOrdenado);
    fclose(fileID);
end