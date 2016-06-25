function [ salida ] = burbuja(vec)
n=size(vec);
for i=1:n(1)                           
   for j=1:n(1)                  
        if(j+1<=n(1)&& vec(j,2)>vec(j+1,2))  
            aux=vec(j,1); 
            aux2=vec(j,2);     
            vec(j,1)=vec(j+1,1);  
            vec(j,2)=vec(j+1,2);   
            vec(j+1,1)=aux;   
            vec(j+1,2)=aux2;       
        end
   end
end
salida=vec;
end

