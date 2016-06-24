for k=1:1
    nameImg=strcat('.\Img\',num2str(k),'.jpg');
    img_RGB = imread(nameImg);
    img_gray=rgb2gray(img_RGB);
    [n,m]=size(img_gray);
    rotuloLBP=[0 1 2 3 4 6 7 8 12 14 15 16 24 28 30 31 32 48 56 60 62 63 64 96 112 120 124 126 127 128 129 131 135 143 159 191 192 193 195 199 207 223 224 225 227 231 239 240 241 243 247 248 249 251 252 253 254 255];
    [a,nRotulos]=size(rotuloLBP);
    descriptorLBP=zeros(1,nRotulos+2); %Tamaño 60,  '1' : nombre de imagen , '2:60': lo 59 rotulos
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
                   descriptorLBP(b+1)=descriptorLBP(b+1)+1; 
                   bandUniforme=true;
                   break;
                end
            end
            if bandUniforme==false
                descriptorLBP(nRotulos+2)=descriptorLBP(nRotulos+2)+1; 
            end 
        end
    end
    fprintf('%d ',rotuloLBP);
    fprintf('\n');
    fprintf('%d ',descriptorLBP);
    fprintf('\n');
end