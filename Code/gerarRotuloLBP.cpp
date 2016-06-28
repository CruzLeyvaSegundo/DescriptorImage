// Author:       -Segundo David Junior Cruz Leyva      
//
// Date:         Junho 02, 2016  
//
// Course:   PI
// 
// Purpose    : Obtain uniform labels LBP
//
// Parameters : nothing
// 
// Return     : nothing
#include<iostream>
#include<conio.h>
#include<bits/stdc++.h>
using namespace std;
int totalN;
FILE *fd,*fs;
void validar(int n)//Convierte un entero a su respectivo binario con el tamano de bit deseado
{
	int numero=n;
	bool band=true;
	int aux=-1,cont=0;
	int formato=8;
	char numBin[8];
	int residuo,k=formato-1;
	for(int i=0;i<formato;i++)
		numBin[i]='0';
	numBin[formato]='\0';
	while(k>=0)
	{
		residuo=n%2;
		n=n/2;
		if(aux==-1)
			aux=residuo;
		else
		{
			if(aux!=residuo)
			{
				cont++;		
				aux=residuo;		
			}	
		}
		numBin[k]=(char)(residuo+48);
		k--;		
	}
	if(cont<=2)
	{
		fprintf(fd,"%d ",numero);
		fprintf(fs,"%d ",totalN);	
		totalN++;
		cout<<numero<<" --> "<<numBin<<"\n";
	}
}

int main()
{
	totalN=0;
	if((fd=fopen("arrayLBP.txt","wt")) == NULL)
        puts("\n the file can't be open");
    if((fs=fopen("arrayIndices.txt","wt")) == NULL)
        puts("\n the file can't be open");
	for(int i=0;i<=255;i++)
	{
		validar(i);
	}
	cout<<"Numeros total encontrados: "<<totalN<<"\n";
	fclose(fd);
	fclose(fs);
	system("pause");
}
