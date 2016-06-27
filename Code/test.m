file = fopen('simCosenos.txt','wt');
%%Cargando vectores LBP 
fileID = fopen('baseDatosLBP.txt','r');
fileID2 = fopen('baseFourier.txt','r');
nImg=10000;
lbpOrdenado=zeros(nImg,60);
fourierOrdenado=zeros(nImg,401);
wb = waitbar(0,'Cargando base de datos(Descriptores de imagenes)');
for i=1:nImg
    waitbar(i/(nImg*2-1), wb);
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

[n m]=size(lbpOrdenado);
for i=9451:9451
    waitbar((i+nImg)/(nImg*2-1), wb);
    q=lbpOrdenado(i,(2:end));
    for j=1:n(1)
        p=lbpOrdenado(j,(2:end));
        simCos=simCoseno(q,p);
        fprintf(file,'Similitud entre el img %d  y img %d es de %8.3f',lbpOrdenado(i,1),lbpOrdenado(j,1),simCos);
        fprintf(file,'\n');
    end
    fprintf(file,'---------------------------\n');
end
close(wb);
fclose(file);
fclose(fileID);
fclose(fileID2);