function [] = busqBinaria(baseDatos,descriptor,img)
[n,m]=size(baseDatos);
first = 1;
last = n;
while (first <= last-2) 
    middle = floor((first+last)/ 2);
    ant=middle-1;
    pos=middle+1;
    simAnt=simCoseno(descriptor,baseDatos(ant,(2:end)));
    simMedio=simCoseno(descriptor,baseDatos(middle,(2:end)));
    simPos=simCoseno(descriptor,baseDatos(pos,(2:end)));
    fprintf('Comparando imagen %d mas parecida %d: %1.5f  %d: %1.5f %d: %1.5f \n',img,baseDatos(ant,1),simAnt,baseDatos(middle,1),simMedio,baseDatos(pos,1),simPos); 
    if(simAnt>simMedio)
        last = middle - 1;
        fprintf('SinAnt mayor : first= %d  last= %d\n ',first,last);
        pivote=last;
    elseif(simPos>simMedio)
        first = middle + 1;
        fprintf('SinPos mayor : first= %d  last= %d\n ',first,last);
        pivote=first;
    else%if(simPos<=simMedio&&simAnt<=simMedio)
        %last = last - 1;
        %first = first + 1;
        fprintf('Estandar : first= %d  last= %d\n ',first,last);
        pivote=middle;
        break;
    end
end
fprintf('Imagen mas parecida %d  %d  %d --- %d \n',baseDatos(ant,1),baseDatos(middle,1),baseDatos(pos,1),baseDatos(pivote,1)); 
end

