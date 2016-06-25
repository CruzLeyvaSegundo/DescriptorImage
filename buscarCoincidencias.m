%%%%%%%%%%Cargar Base de datos%%%%%%%%%%%%%%%%
%%Cargando vectores LBP 
fileID = fopen('baseDatosLBP.txt','r');
nImg=30;
lbpOrdenado=zeros(nImg,60);
for i=1:nImg
    img=fscanf(fileID,'%d',1);
    lbpOrdenado(i,1)=img;
    lbpOrdenado(i,(2:end))=fscanf(fileID,'%d',59);
    fprintf('%d ',lbpOrdenado(i,1));
    fprintf('%d ',lbpOrdenado(i,(2:end)));
    fprintf('\n');    
end
%%Cargando registro de indexacion 
registroIndex=zeros(1,nImg);
registroIndex(i,:)=fscanf(fileID,'%d',nImg);
fprintf('%d ',registroIndex(i,:));
fprintf('\n');  
%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP %%%%%%%%%%%%%%%%%%%%%%%%%%
img=1;  %Imagen que se utilizara para la query
k=5; %Numero de coincidencias a reportar
nameImg=strcat('.\Img\',num2str(img),'.jpg');
img_RGB = imread(nameImg);
img_gray=rgb2gray(img_RGB);
descriptorLBP=hallarVectorLBP(img_gray); %Tamaño 59, '1:59': lo 59 rotulos
%%%% Busqueda por tabla de hash  o Implementar Busqueda binaria%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fileID);