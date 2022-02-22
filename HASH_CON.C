#include<stdio.h>
#define MAXTABLE 701

typedef struct plist *plist;
typedef struct plist
		   {
		   int info;
		   plist prec;
		   plist next;
		   }slist;

plist table[MAXTABLE];
int key,totimeh,timeh,number;


void cls()
{
int i;

for(i=0;i<30;i++) printf("\n");
}

plist alloc(key) /*procedura per allocamento in memoria di un tipo plist*/
int key;
{
plist new;

new=(plist)malloc(sizeof(slist));/*crea un nuovo nodo di tipo plist  */
new->info=key;                   /*e di ampiezza slist               */
new->next=NULL;                  /*inizializzo i campi del nuovo nodo*/
new->prec=NULL;

return(new);
}

int fmod(x,y)
int x,y;
{
int comodo;

comodo=x/y;

return (x-(comodo*y));
}

int hash(valore) /*posizione di valore nella tabella hash*/
int valore;
{
return fmod(valore,MAXTABLE);
}

void carhash(nkey)
int nkey;
{
int slot;
plist node;
extern plist table[];   /*tabella*/
extern int timeh;       /*contatore operazioni*/

slot=hash(nkey); /*ricava la posizione in table grazie alla funzione hash*/
timeh++;
node=alloc(nkey);
node->next=table[slot];/*inserisce in testa alla lista table[slot]*/
timeh+=3;
if(table[slot] != NULL)
	{
	table[slot]->prec=node;
	timeh++;
	}
table[slot]=node;
}

plist searchtab(key)
int key;
{
extern plist table[];
extern timeh;
plist node;
int slot;

slot=hash(key);timeh+=3;
node=table[slot];
while((node != NULL) && (node->info != key))
	{
	timeh+=2;
	node=node->next;
	}
return (node);
}

void deltab(key)
int key;
{
extern plist table[];
extern int timeh;
plist node;

node=searchtab(key);
timeh++;
if(node != NULL)
	{
	timeh+=4;
	if(node->prec != NULL) node->prec->next=node->next;
	else
		{
		table[hash(key)]=node->next;
		timeh++;
		}
	if(node->next != NULL)
		{
		node->next->prec=node->prec;
		timeh++;
		}
	free(node);
	}
else printf("ELEMENTO NON PRESENTE NELLA TABELLA\n\n");
}

void printable()
{
int i=0;
plist node;
extern plist table[];

for(i=0;i<MAXTABLE;i++)
	{
	if(table[i] != NULL)
		{
		printf("\n Posizione --> %4d * ",i);
		for(node=table[i];node != NULL;node=node->next)
			printf("    %4d",node->info);
		printf("\n");
		}
	}
}

void tempo()
{
extern int timeh;

printf("\nTempo di esecuzione con HASH TABLE --> %4d\n",timeh);
timeh=0;
}

void mainins()
{
int nkey;
char ris;

printf("                       **********INSERIMENTO**********\n");
do
{
	printf("\nNumero: ");scanf("%d",&nkey);
	carhash(nkey);
	number++;
	totimeh+=timeh;
	printf("\nVuoi inserire un altro numero ? (s/n)-");
	rewind(stdin);
	ris=getchar();
}
while(ris != 'n');
rewind(stdin);
printf("\n------------------------>>>INSERIMENTO ULTIMATO \n\n\n\n\n\n");
}

main()
{
char scelta;
plist node;

cls();
do
 {
 printf("\n\n\n");
 printf("*** MANIPOLAZIONE DI INSIEMI TRAMITE TABELLE HASH ***\n\n");
 printf("                      MENU'                          \n");
 printf("\t\t 1) Insert\n");
 printf("\t\t 2) Search\n");
 printf("\t\t 3) Delete\n");
 printf("\t\t 4) Print \n");
 printf("\t\t 0) Exit  \n");
 printf("Scelta: ");scanf("%d",&scelta);printf("\n");
 switch(scelta)
	{
	case 1:{
	       cls();
	       mainins();
	       break;
	       }
	case 2:{
	       cls();
	       printf("\nQuale elemento vuoi cercare ? :");
	       rewind(stdin);
	       scanf("%d",&key);
	       node=searchtab(key);
	       if(node != NULL)
		printf("\nElemento: %d presente nella tabella hash !\n",key);
	       else
		printf("\nElemento: %d non presente nella tabella hash !\n",key);
	       break;
	       }
	case 3:{
	       cls();
	       printf("\nQuale elemento vuoi eliminare ? ->");
	       rewind(stdin);
	       scanf("%d",&key);
	       deltab(key);
	       printf("\nElemento ->%d eliminato.\n",key);
	       break;
	       }
	case 4:{
	       cls();
	       printable();
	       break;
	       }
	default:break;
	}
 }
while(scelta);
tempo();
}