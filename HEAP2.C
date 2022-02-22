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

int conta_legge()
{
int i,j;
char b[80];

printf("\nInserisci una stringa -> ");gets(b);
j=0;
while(b[j] != '\0')
	{
	a[j+1]=b[j];
	j++;
	}
printf("\nStringa inserita %s \n",a+1);
n=j;

return(n);
}

void build_heap()
{
int i,j;

j=(int)floor(n / 2);
for(i=j;i>=1;i--)
heapify(i);

return;
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
max=maximum(a);
a[1]=a[heap_size--];
n--;
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
char temp;

n=conta_legge();
heap_size=n;
printf("\nLa stringa %s Š lunga %d \n\n",a+1,n);
do
{
printf("Seleziona una delle seguenti funzioni sulle code di priorit…:\n");
printf("1) Ordinare l'array \n");
printf("2) Ricercare l'elemento di priorit… massima \n");
printf("3) Inserire un nuovo elemento nel vettore \n");
printf("4) Eliminare l'elemento di priorit… massima \n");
printf("0) Uscita \n");
scanf("%d",&scelta);
switch(scelta)
	{
	case 1:
		{
		heapsort();
		for(i=1;i<=n;i++) printf("%c\t",a[i]);
		printf("\n");
		heap_size=n;
		break;
		}
	case 2:
		{
		build_heap();
		temp=maximum();
		printf("Elemento di priorit… massima: %c \n",temp);
		break;
		}
	case 3:
		{
		printf("Inserire il nuovo elemento: ");getchar();
		temp=getchar();
		heap_insert(temp);
		printf("Lista dopo inserimento: %s\n",a+1);
		break;
		}
	case 4:
		{
		build_heap();
		temp=heap_exctract_max(temp);
		printf("Elemento di priorit… massima eliminato: %c \n",temp);
		break;
		}
	default:break;
	}}
while(scelta);
}

