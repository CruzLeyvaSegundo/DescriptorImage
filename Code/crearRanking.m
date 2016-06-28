% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 15, 2016  
%
% Course:   PI
% 
% Function   : descriptorFourier
% 
% Purpose    : Creates the ranking of descriptors in base of cosine similarity of query
% 
% Parameters : simCosenos(cosine similarity in base of query) , descLBP(It contains all descriptors)
% 
% Return     : lbpOrdenado(It contains all semi-ordered descriptors)
function [ lbpOrdenado ] = crearRanking(simCosenos,descLBP,op)
    n=size(simCosenos);
    m=size(descLBP);
    lbpOrdenado=zeros(n(1),m(2)+1);
    % ranking=quickSort(comCosenos,1,n(1));
    ranking=heapsort(simCosenos);
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
        if(op==2)
            vecAux(k,2)=distEuclidiana(q,p);   
        elseif(op==1)
            vecAux(k,2)=simCoseno(q,p);  
        end
        k=k+1;
    end

    ranking2=heapsort(vecAux);   
    k=1;
    for j=1:n(1)-1
        if(op==2)
            matrizAux(k,1)=ranking2(j,1);
            matrizAux(k,(2:end))=descLBP(matrizAux(k,1),:);
        elseif(op==1)
            matrizAux(k,1)=ranking2(n(1)-j,1);
            matrizAux(k,(2:end))=descLBP(matrizAux(k,1),:);            
        end
        k=k+1;
    end
    lbpOrdenado(2:n(1),:)=matrizAux;
end


