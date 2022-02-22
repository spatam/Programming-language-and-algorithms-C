#include<stdio.h>
#include<string.h>
#define HASHSIZE 101

typedef struct plist plist;
typedef struct plist{
		    char *name;
		    char *defn;
		    plist *next;
		    }slist;

/*dichiarazione della tabella dei puntatori a tipo static plist*/
static plist *hashtab[HASHSIZE];

void cls()
{
int i;
for(i=0;i<30;i++) printf("\n");
}

/*hash:calcola il valore di hashing della stringa s */
unsigned hash(char *s)
{
unsigned hashval;

for(hashval=0;*s != '\0';s++)
	hashval = *s + 31*hashval;
return (hashval % HASHSIZE);
}

/*lookup:cerca s in hashtab(tabella hash) */
plist *lookup(char *s)
{
plist *np;

for(np=hashtab[hash(s)];np != NULL; np=np->next)
	if(strcmp(s,np->name)==0) return(np);
return (NULL);
}

/*strdupl:duplica una stringa*/
char *strdupl(char *s)
{
char *p;

p=(char *)malloc(strlen(s)+1);
if (p != NULL) strcpy(p,s);

return (p);
}

/*install:inserisce (name,defn) in hashtab */
plist *install(char *name,char *defn)
{
plist *np;
unsigned hashval;

if ((np=lookup(name))==NULL)
	{
	np=(plist *)malloc(sizeof(slist));
	if(np == NULL || (np->name = strdupl(name)) == NULL) return NULL;
	hashval=hash(name);
	np->next=hashtab[hashval];
	hashtab[hashval]=np;
	}
else free((void *)np->defn);
if ((np->defn=strdupl(defn))==NULL) return NULL;

return (np);
}

void  stampa(plist *p[])
{
plist *aux;
int i;

cls();
printf("Lista...........\n\n");
for(i=0;i<HASHSIZE;i++)
	for(aux=hashtab[i];aux != NULL;aux=aux->next)
	printf("%s ---- %s\n",aux->name,aux->defn);
printf("\n\n");
printf(" - Premi Enter - ");
rewind(stdin);
}

void insert()
{
plist *p;
char *nome,*defi;
char ris;

do
	{
	 printf("\nNome: ");rewind(stdin);gets(nome);
	 cls();
	 printf("\nDefinizione: ");rewind(stdin);gets(defi);
	 cls();
	 printf("\nNOME: %s",nome);
	 printf("\nDEFINIZIONE: %s",defi);
	 p=install(nome,defi);
	 printf("\nVuoi inserire altri elementi ?  (s/n)-");rewind(stdin);
	 ris=getchar();
	}
while(ris != 'n');
}

main()
{
plist *p;

cls();
rewind(stdin);
insert();
stampa(p);
scanf("\n");
}
