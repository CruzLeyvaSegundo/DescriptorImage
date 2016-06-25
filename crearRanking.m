function [ lbpOrdenado ] = crearRanking(comCosenos,descLBP)
n=size(comCosenos);
m=size(descLBP);
lbpOrdenado=zeros(n(1),m(2)+1);
% ranking=quickSort(comCosenos,1,n(1));
ranking=burbuja(comCosenos);
for i=1:n(1)
    lbpOrdenado(i,1)=ranking(n(1)-i+1,1);
    lbpOrdenado(i,(2:end))=descLBP(ranking(n(1)-i+1,1),:);
end

q=lbpOrdenado(1,(2:end));
vecAux=zeros(n(1)-1,2);
matrizAux=zeros(n(1)-1,m(2)+1);
k=1;
for j=2:n(1)
    p=lbpOrdenado(j,(2:end));
    vecAux(k,1)=lbpOrdenado(j,1);
    vecAux(k,2)=simCoseno(q,p);    
    k=k+1;
end

ranking2=burbuja(vecAux);   
k=1;
for j=2:n(1)
    matrizAux(k,1)=ranking2(n(1)-j+1,1);
    matrizAux(k,(2:end))=descLBP(matrizAux(k,1),:);
    k=k+1;
end
lbpOrdenado(2:n(1),:)=matrizAux;

end


