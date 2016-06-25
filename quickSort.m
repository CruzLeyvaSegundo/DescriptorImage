function [salida] = quickSort(vect,izq,der)
i = izq; 
j = der; 
m=floor((izq + der)/2);
x = vect(m,2); 
first=true;
while( i < j || first); 
    while( (vect(i,2) < x) && (j <= der) )
           i=i+1;
    end
    while( (x < vect(j,2)) && (j >izq) )
           j=j-1;
    end
    if( i <= j )
        aux = vect(i,2); 
        aux2= vect(i,1); 
        vect(i,2) = vect(j,2); 
        vect(j,2) = aux; 
        vect(i,1) = vect(j,1); 
        vect(j,1) = aux2; 
        i=i+1;  
        j=j-1; 
    end
    x = vect(m,2); 
    first=false;
end
salida=vect; 
if( izq < j ) 
    salida=quickSort(vect,izq,j); 
end
if( i < der ) 
    salida=quickSort(vect,i,der); 
end
end

