#include<stdio.h>

int n;

void cls()
{
int i;

for(i=0;i<30;i++) printf("\n");
}

int *insert(int *a,int *b,int *c)
{
int i,x;

printf("\nQuanti numeri vuoi inserire ? ");scanf("%d",&n);
a=(int *)calloc(n,sizeof(i));
b=(int *)calloc(n,sizeof(i));
c=(int *)calloc(n,sizeof(i));
for(i=1;i<=n;i++)
        {
        printf("\nNumero: ");
        scanf("%d",&x);
        a[i]=x;
        }
return(a);
}

int *counting_sort(int *a,int *b,int *c,int k)
{
int i,j;

k=100;
for(i=1;i<=k;i++) c[i]=0;
for(j=1;j<=n;j++) c[a[j]]+=1;
for(i=2;i<=k;i++) c[i]+=c[i-1];
for(j=n;j>=1;j--)
        {
        b[c[a[j]]]=a[j];
        c[a[j]]-=1;
        }

return (b);
}

void stampa(int *a)
{
int i;

for(i=1;i<=n;i++) printf("%d ",a[i]);
printf("\n");
}

main()
{
int *a,*b,*c;
int k;

cls();
printf("\n==============COUNTING-SORT========================\n");
a=insert(a,b,c);
printf("\nLista inserita:->>> ");stampa(a);
b=counting_sort(a,b,c,k);
printf("\nLista ordinata:->>> ");stampa(b);
scanf("\n");
}
