% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 18, 2016  
%
% Course:   PI
% 
% Function   : verificarRanking
%
% Purpose    : Shows the similarity between the generated ranking Descritores
% 
% Parameters : vectorLBP (vectores Ordenados)
% 
% Return     : nothing
function [] = verificarRanking( vectorLBP )
    n=size(vectorLBP);
    for i=1:n(1)-1
        q=vectorLBP(i,(2:end));
        for j=i+1:n(1)
            p=vectorLBP(j,(2:end));
            simCos=distEuclidiana(q,p);
            fprintf('Similitud entre el img %d  y img %d es de %8.3f',vectorLBP(i,1),vectorLBP(j,1),simCos);
            fprintf('\n');
        end
        fprintf('---------------------------\n');
    end
end

