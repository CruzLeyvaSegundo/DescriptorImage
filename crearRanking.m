function [ lbpOrdenado ] = crearRanking(comCosenos,descLBP)
n=size(comCosenos);
m=size(descLBP);
lbpOrdenado=zeros(n(1),m(2)+1);
% ranking=quickSort(comCosenos,1,n(1));
ranking=burbuja(comCosenos);
for i=1:n(1)
    lbpOrdenado(i,1)=ranking(i,1);
    lbpOrdenado(i,(2:end))=descLBP(ranking(i,1),:);
end
end

