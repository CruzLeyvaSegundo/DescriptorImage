fileID = fopen('baseDatosLBP.txt','wt');
rotuloLBP=[0 1 2 3 4 6 7 8 12 14 15 16 24 28 30 31 32 48 56 60 62 63 64 96 112 120 124 126 127 128 129 131 135 143 159 191 192 193 195 199 207 223 224 225 227 231 239 240 241 243 247 248 249 251 252 253 254 255];
[a,nRotulos]=size(rotuloLBP);
nImg=30;
lbpOriginal=zeros(nImg,59);
lbpNormalizado=zeros(nImg,59);
wb = waitbar(0,'Creando base de datos(Descriptores de imagenes)');
for k=1:nImg
    waitbar(k/nImg, wb);
    nameImg=strcat('.\Img\',num2str(k),'.jpg');
    img_RGB = imread(nameImg);
    img_gray=rgb2gray(img_RGB);
    [n,m]=size(img_gray);
    descriptorLBP=zeros(1,nRotulos+1); %Tamaño 59, '1:59': lo 59 rotulos
    for i=2:n-1
        for j=2:m-1
            suma=0;
            if img_gray(i,j+1)>img_gray(i,j) 
                suma=suma+1;
            end
            if img_gray(i+1,j+1)>img_gray(i,j)
                suma=suma+2;
            end
            if img_gray(i+1,j)>img_gray(i,j)
                suma=suma+4;
            end
            if img_gray(i+1,j-1)>img_gray(i,j)
                suma=suma+8;
            end
            if img_gray(i,j-1)>img_gray(i,j)
                suma=suma+16;
            end
            if img_gray(i-1,j-1)>img_gray(i,j)
                suma=suma+32;
            end
            if img_gray(i-1,j)>img_gray(i,j)
                suma=suma+64;
            end
            if img_gray(i-1,j+1)>img_gray(i,j)
                suma=suma+128;
            end
            bandUniforme=false;
            %fprintf('pixel(%d , %d)= %d con rotulo %d \n',i,j,img_gray(i,j),suma);
            for b=1:nRotulos
                if rotuloLBP(b)==suma
                   descriptorLBP(b)=descriptorLBP(b)+1; 
                   bandUniforme=true;
                   break;
                end
            end
            if bandUniforme==false
                descriptorLBP(nRotulos+1)=descriptorLBP(nRotulos+1)+1; 
            end 
        end
    end
    lbpOriginal(k,:)=descriptorLBP;
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
%Se guardan los ranking generados
for i=1:nImg
    fprintf('%8.3f ',simCosenoLBP(end-i+1,:));
    fprintf('\n');
    fprintf(fileID,'%d ',lbpOrdenado(i,1));
    fprintf(fileID,'%d ',lbpOrdenado(i,(2:end)));
    fprintf(fileID,'\n');
end
fprintf('\n');
verificarRanking(lbpOrdenado);
close(wb);
fclose(fileID);