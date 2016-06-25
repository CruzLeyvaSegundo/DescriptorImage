function [] = verificarRanking( vectorLBP )
n=size(vectorLBP);
% for i=1:n(1)-1
%     q=vectorLBP(i,(2:end));
%     p=vectorLBP(i+1,(2:end));
%     simCos=simCoseno(q,p);
%     fprintf('Similitud entre el img %d  y img %d es de %8.3f',vectorLBP(i,1),vectorLBP(i+1,1),simCos);
%     fprintf('\n');
% end
for i=1:n(1)-1
    q=vectorLBP(i,(2:end));
    for j=i+1:n(1)
        p=vectorLBP(j,(2:end));
        simCos=simCoseno(q,p);
        fprintf('Similitud entre el img %d  y img %d es de %8.3f',vectorLBP(i,1),vectorLBP(j,1),simCos);
        fprintf('\n');
    end
    fprintf('---------------------------\n');
end


end

