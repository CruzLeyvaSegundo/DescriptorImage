fileID = fopen('baseDatosLBP.txt','wt');
% fileRepuesto = fopen('baseRepuesto.txt','wt');
nImg=20;
lbpOriginal=zeros(nImg,59);
lbpNormalizado=zeros(nImg,59);
descriptorLBP=zeros(1,59);
wb = waitbar(0,'Creando base de datos(Descriptores de imagenes)');
for k=1:nImg
    waitbar(k/nImg, wb);
    nameImg=strcat('.\Img\',num2str(k),'.jpg');
    img_RGB = imread(nameImg);
    img_gray=rgb2gray(img_RGB);
    descriptorLBP=hallarVectorLBP(img_gray); %Tamaño 59, '1:59': lo 59 rotulos
    lbpOriginal(k,:)=descriptorLBP;
%     fprintf(fileRepuesto,'%d ',k);
%     fprintf(fileRepuesto,'%d ',descriptorLBP);
%     fprintf(fileRepuesto,'\n');
    lbpNormalizado(k,:)=descriptorLBP./norm(descriptorLBP);
end

simCosenoLBP=zeros(nImg,2); % nombre y simulitud con la query son guardados aca
%lbpOrdenado Aca se almacena el ranking de los descritores con respecto a la query
query=ones(1,59);
query=query./norm(query);
%Calculo de la similitud de coseno de los vectores con respecto a una qeury
for i=1:nImg
    simCosenoLBP(i,1)=i;
    simCosenoLBP(i,2)=simCoseno(query,lbpNormalizado(i,:));
    fprintf('%8.3f ',simCosenoLBP(i,:));
    fprintf('\n');
end
fprintf('+++++++++++++++++++++++++++\n');
%Se ordenan los ranking
lbpOrdenado=crearRanking(simCosenoLBP,lbpOriginal);
simCosenoLBP=burbuja(simCosenoLBP);
registroIndex=zeros(1,nImg);
%SE GUARDA EL RANKING DE LOS VECTORES LBP
for i=1:nImg
    fprintf('%8.3f ',simCosenoLBP(end-i+1,:));
    fprintf('\n');
    registroIndex(lbpOrdenado(i,1))=i;
    fprintf(fileID,'%d ',lbpOrdenado(i,1));
    fprintf(fileID,'%d ',lbpOrdenado(i,(2:end)));
    fprintf(fileID,'\n');
end
%SE GUARDA EL REGISTRO DE INDEXACION DE LOS VECTORES LBP 
fprintf(fileID,'%d ',registroIndex(1,:));
fprintf('\n');
verificarRanking(lbpOrdenado);
close(wb);
% fclose(fileRepuesto);
fclose(fileID);