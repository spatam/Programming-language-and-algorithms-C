#include<stdio.h>
#include<math.h>

int heap_size,n;
char a[80];

void cls()
{
int i;

for(i=0;1<30;i++) printf("\n");
}

int parent(int i)
{
return (int)floor(i/2);
}

int left(int i)
{
return (i*2);
}

int right(int i)
{
return (i*2+1);
}

void swap(char *v,char *t)
{
char temp;

temp=*v;
*v=*t;
*t=temp;
}

void heapify(int i)
{
int l,r,largest;

l=left(i);
r=right(i);
if((l<=heap_size) && (a[l]>a[i])) largest=l;
			     else largest=i;
if((r<=heap_size) && (a[r]>a[largest])) largest=r;
if(largest != i)
	{
	swap(&(a[i]),&(a[largest]));
	heapify(largest);
	}
}


void build_heap()
{
int i,j;

j=(int)floor(n / 2);
for(i=j;i>=1;i--)
heapify(i);

}

void heapsort()
{
int i;

build_heap();
for(i=n;i>=2;i--)
	{
	swap(&(a[1]),&(a[i]));
	heap_size--;
	heapify(1);
	}
return;
}

char maximum()
{
return (a[1]);
}

char heap_exctract_max()
{
char max;

if(heap_size<1) printf("\nERROR");
max=a[1];
a[1]=a[heap_size--];
heapify(1);

return(max);
}

void heap_insert(char key)
{
int i;

heap_size++;
i=heap_size;
while(i>1 && a[parent(i)]<key)
	{
	a[i]=a[parent(i)];
	i=parent(i);
	}
a[i]=key;
}

main()
{
int i,scelta;
char key,x,temp,b[80];

printf("\nInserisci una stringa ->");gets(b);

n=0;
while(b[n] != '\0')
{
    a[n+1]=b[n];
    n++;
}

printf("\n Stringa inserita: %s con dimensione: %d",a+1,n);
for (i=1;i<=n;i++) printf("%c ",a[i]);printf("\n");

heap_size=n;

printf("\n 1) Ordinare l'array \n");
heapsort();

for(i=1;i<=n;i++) printf("%c",a[i]);

heap_size=n;
printf("\nheap_size=%d",heap_size);

printf("\n2) Ricercare l'elemento di priorit… massima \n");
build_heap();
temp=maximum();
printf("Elemento di priorit… massima: %c",temp);

printf("\n3) Inserire un nuovo elemento nel vettore \n");
printf("Inserire il nuovo elemento: ");scanf("%c",&temp);
heap_insert(temp);
printf("Stampa della nuova lista: %s",a+1);

printf("\n4) Eliminare l'elemento di priorit… massima \n");
build_heap();
temp=heap_exctract_max(temp);
printf("Elemento di priorit… massima eliminato: %c %s \n",temp,a+1);

printf("5) Uscita ");
scanf("\n");
}

