/*Questo programma si occupa di calcolare il prodotto a catena di n matrici
fornite in input tramite il file dati.txt nel quale figura: nella prima riga
un vettore di dimensioni delle matrici i cui elementi sono sequenzialmente
introdotti successivamente.Il problema del prodotto a catena di matrici
rappresenta l'esempio classico della programmazione dinamica al
quale ci riferiremo per applicare degli algoritmi di risoluzione quali:
MATRIX_CHAIN_ORDER MATRIX_MULTIPLY MATRIX_CHAIN_MULTIPLY;essi trattano
tale problema tramite i cosidetti "problemi di ottimizzazione".
Questi problemi ammettono diverse soluzioni ed ad ognuna di queste verra'
associato un valore, naturalmente si desidera determinare la soluzione con il
valore ottimo (a seconda il massimo o il minimo valore) che non e' la
soluzione ottima del problema bensi' una soluzione ottima del problema e che
nel nostro caso sara' il minimo fra i numeri di prodotti scalari possibili .
Gli algoritmi di programmazione dinamica sopracitati risolvono ciascun
sottoproblema una sola volta e memorizzano la soluzione in una tabella, cosi'
facendo si evitera' di calcolarne la soluzione ogni qualvolta si dovra'
risolvere lo stesso sottoproblema.*/

#include<stdio.h>
#include<limits.h>

typedef struct pnode *pnode;
typedef struct pnode
		{int **a;
		 int rows,columns;
		 pnode next;}snode;
int cont=0;
int **s,**m;
int *p=NULL;
pnode h=NULL,t=NULL;
FILE *file;

/*Questa e' una funzione di clear screen*/

void cls()
{
int i;

for(i=0;i<30;i++) printf("\n");
}

/*Questa funzione permette la creazione di un nuovo nodo  di tipo pnode*/

pnode make_node_pnode(int **m,int i,int j)
{
pnode newnode=NULL;

newnode=(pnode)malloc(sizeof(snode));
newnode->a=m;
newnode->rows=i;
newnode->columns=j;
newnode->next=NULL;

return(newnode);
}

/*Questa funzione si occupa di allocare dinamicamente una tabella di tipo
matrice tramite la funzione calloc che alloca in locazioni di memoria
successive dapprima le "r" righe e successivamente con un ciclo for che va
da 0 ad "r" le "c" colonne*/

int **alloca(int r,int c)
{
int **M,y;

M=(int **)calloc(r,sizeof(int *));
for(y=0;y<r;y++) M[y]=(int *)calloc(c,sizeof(int));

return M;
}

/*procedura di stampa di una matrice*/

void stampa(int **M,int r,int c)
{
int j,k;

printf(" MATRICE ................ \n\n");
for(j=0;j<r;j++)
	for(k=0;k<c;k++)
	{
	if(k==0) printf("|");
	printf("%3d ",M[j][k]);
	if(k==c-1) printf("|\n");
	}

printf("\n-PREMI ENTER-");
rewind(stdin);getchar();
}

/*procedura per inserimento in una coda di un nodo di tipo pnode*/

void ins_coda_pnode(int **c,int i,int j)
{
pnode newnode=(pnode)malloc(sizeof(snode));

newnode=make_node_pnode(c,i,j);
if(h==NULL) t=h=newnode;
else t->next=newnode;
t=newnode;
}

/*procedura che alloca la matrice di dimensioni  p[cont], p[cont+1] e che
ne legge tutti gli elementi dal file input inserendola nella coda ed infine
stampandola*/

void init(int c,pnode mt)
{
int x,j;
int **A=NULL;

A=alloca(mt->rows,mt->columns);
for(x=0;x<mt->rows;x++)
	for(j=0;j<mt->columns;j++)
		fscanf(file,"%d",&A[x][j]);

mt->a=A;
printf("\n");
printf("A%d",c);
stampa(A,mt->rows,mt->columns);
}

/*questa procedura ricorsiva sfrutta la proprieta' che tutte le possibili
parentesizzazioni ottimali, definiscono la medesima matrice risultato;
questa e' la questione fondamentale del problema poiche' la struttura della
parentesizzazione di una sequenza di matrici influisce sul calcolo del
prodotto matriciale in termini di numero di prodotti scalari effettuati*/

void parentex(int i,int j)
{
if(i==j) printf("A%d ",i+1);
else
	{
	printf("(");
	parentex(i,s[i][j]-1);
	parentex(s[i][j],j);
	printf(")");
	}
}

/*procedura per la verifica di inserimento di almeno una matrice*/

void zero_matrix()
{
 printf("\nATTENZIONE nessuna matrice inserita !\n");
 rewind(stdin);
 getchar();
 exit();
}

/*procedura per la verifica che il numero di coppie righe colonne sia corretto*/

void dispari()
{
 printf("\nATTENZIONE sono state inserite nel file un numero di dimensioni errato !\n");
 printf("OCCORRE inserire un numero pari di coppie righe e colonne !!!!!!!!!!!!!!!!\n");
 rewind(stdin);
 getchar();
 exit();
}

/*procedura per la verifica della compatibilita' del prodotto*/

void control(int n,pnode head)
{
int j=0;

p=(int *)calloc(n,sizeof(int));
p[j]=head->rows;
while (head->next != NULL)
    if(head->columns == head->next->rows)
		{p[++j]=head->columns;
		 head=head->next;}
    else
    {printf("Attenzione lettura dimensioni matrici non compatibili !\n");
		 rewind(stdin);
		 printf("\n-Premi Enter-\n");getchar();
		 exit();}
 p[++j]=head->columns;
}

/*questa procedura legge il file dati.txt*/

void read_file()
{
/* h testa della lista di matrici */
pnode node;
static char str[10];
int i=0,x,r,c=0;

file=fopen("dati.txt","r");
while (strcmp(str,"."))
	{fscanf(file,"%s",str);
	 x=atoi(str);
	 if (strcmp(str,"."))
	     if ((i % 2)==0) r=x;
		else ins_coda_pnode(NULL,r,x);
	 i++;
	}
i--;
if(i<=2) zero_matrix();
else if((i % 2) != 0) dispari();
else
	{i=i/2+1;
	 control(i,h);}
fscanf(file,"\n");

cont=i-1;
node=h;
while (node!=NULL)
	{init(++c,node);
	 node=node->next;}
fclose(file);
}

/*questa procedura passando una generica matrice me ne restituisce le dimensioni*/

void dimension(int **z,int *A,int *B)
{
pnode head=NULL;

head=h;
while(z != head->a)
	head=head->next;
*A=head->rows;
*B=head->columns;
}

/*Questa procedura calcola il costo di una soluzione ottima in modalita'
bottom-up.Essa assume che la generica matrice A[i] abbia dimensioni
p[i-1]*p[i] con i=1,2,.....,n.Il dato di input e' il vettore p con dimensioni
eguali al numero di matrici inserite + 1 infatti si considerano per via della
proprieta' sulla compatibilita' del prodotto il primo numero di righe il
primo numero di colonne il secondo numero di colonne il terzo numero di
colonne e cosi via fino a n (a patto che tale proprieta' sia sempre valida);
il dato di output e' la tabella m dei costi, ossia il numero minimo di
moltiplicazioni scalari necessarie per calcolare il prodotto delle matrici,ed
una tabella ausiliaria s per memorizzare il valore dell'indice k per cui
m[i,j] e' un costo ottimo*/

void matrix_chain_order()
{
int q,z,k,j,n,l,i;

n=cont;
for(i=1;i<=n;i++) m[i-1][i-1]=0;
for(l=2;l<=n;l++)
	for(i=1;i<=(n-l+1);i++)
	{
	j=i+l-1;
	m[i-1][j-1]=INT_MAX;
	for(k=i;k<=j-1;k++)
		{
		z=(p[i-1]*p[k]*p[j]);
		q=m[i-1][k-1]+m[k][j-1]+z;
		if(q<m[i-1][j-1])
			{m[i-1][j-1]=q;
			 s[i-1][j-1]=k;}
}       }       }

/*La seguente procedura serve per il calcolo del prodotto di due matrici
naturalmente due matrici
possono essere moltiplicate solo se il numero di colonne di X e' uguale al
numero di righe di Y. Se X e' una matrice p*q ed B q*r allora il prodotto delle
medesime avra' dimensioni p*r.Il tempo necessario per calcolare la matrice
prodotto sara' direttamente proporzionale al numero di prodotti scalari eseguiti*/

int **matrix_multiply(int **X,int **Y)
{
int i,j,k,rx,ry,cx,cy;
int **pr;

dimension(X,&rx,&cx);
dimension(Y,&ry,&cy);
pr=alloca(rx,cy);

if(cx != ry)
	{printf("Errore dimensione matrici non compatibili !\n");
	 printf("-Premi enter-");
	 rewind(stdin);getchar();}
else
	{for(i=1;i<=rx;i++)
		for(j=1;j<=cy;j++)
			{pr[i-1][j-1]=0;
			 for(k=1;k<=cx;k++)
				pr[i-1][j-1]+=((X[i-1][k-1])*(Y[k-1][j-1]));}
	}
ins_coda_pnode(pr,rx,cy);

return pr;
}

/*Funzione per la ricerca di una matrice i-esima*/

int **search_matrix(int index)
{
pnode node=NULL;
int i;

node=h;
for(i=0;i != index;i++)
	node=node->next;

return(node->a);
}

/*La seguente procedura ricorsiva calcola la matrice risultato del prodotto di
una sequenza di n matrici.I parametri della procedura sono la matrice generica
matrix e gli indici i ed j che rispettivamente corrispondono all'indice che
e' associato alla matrice matrix ed al numero di matrici passate in input*/

int **matrix_chain_multiply(int **matrix,int i,int j)
{
int **X,**Y;

if(j>i)
	{X=matrix_chain_multiply(matrix,i,matrix[i-1][j-1]);
	 Y=matrix_chain_multiply(matrix,matrix[i-1][j-1]+1,j);
	 return matrix_multiply(X,Y);}

else return(search_matrix(i-1));
}

void mainins1()
{
 printf("Procedura di caricamento delle matrici .........\n\n");
 read_file();
}

void mainins2()
{
int z;

 printf("\n\nVettore p -> ");
 for(z=0;z<=cont;z++) printf(" %d ",p[z]);printf("\n");
 printf("\n-PREMI ENTER-");
 rewind(stdin);getchar();
}

void mainins3()
{
 m=alloca(cont,cont);
 s=alloca(cont,cont);
 matrix_chain_order();
 printf("Stampa matrici m,s \n\n");
 printf("m: -->");stampa(m,cont,cont);
 printf("\n");
 printf("s: -->");stampa(s,cont,cont);
}

void mainins4()
{
int **pr=NULL;

 printf("Inizio procedura multiply .......................\n");
 pr=matrix_chain_multiply(s,1,cont);
 rewind(stdin);
 printf("\n Matrice prodotto ----->\n\n");
 stampa(pr,p[0],p[cont]);
}

void mainins5()
{
 printf("Il programma ha eseguito %d prodotti scalari.",m[0][cont-1]);
 printf("\n\n-PREMI ENTER-");
 rewind(stdin);getchar();
}

void mainins6()
{
 printf("La parentesizzazione ottima eseguita e' ---------> ");
 parentex(0,cont-1);
 printf("\n\n-PREMI ENTER-");
 rewind(stdin);getchar();
}

void mainins0()
{
 printf("Termine del programma ...........................\n");
 printf("\n\n-PREMI ENTER-\n");
 rewind(stdin);getchar();
}

void main()
{
int scelta;

do
 {
  printf("\n\n");
  printf("==============================================================================\n");
  printf("===============              LINGUAGGIO ANSI C               =================\n");
  printf("===============      PRODOTTO DI UNA SEQUENZA DI MATRICI     =================\n");
  printf("===============  STUDENTE SPATA MASSIMO ORAZIO MATR. 280233  =================\n");
  printf("===============       COMPITO DEL 30/10/1995 SISTEMI I       =================\n");
  printf("==============================================================================\n");
  printf("\n\n\n");
  printf("------------------------------------------------------------------------------\n");
  printf("|                                  MENU'                                     |\n");
  printf("------------------------------------------------------------------------------\n");
  printf("|\t\t 1)Lettura da file caricamento e stampa delle matrici.       |\n");
  printf("|\t\t 2)Stampa vettore 'p' con le dimensioni delle matrici.       |\n");
  printf("|\t\t 3)Caricamento e stampa delle matrici 'm' ed 's'.            |\n");
  printf("|\t\t 4)Prodotto e stampa delle 'n' matrici.                      |\n");
  printf("|\t\t 5)Stampa dei prodotti scalari eseguiti.                     |\n");
  printf("|\t\t 6)Stampa della parentesizzazione ottima.                    |\n");
  printf("|\t\t 0)Exit.                                                     |\n");
  printf("------------------------------------------------------------------------------\n");
  printf("\n\n\n SCELTA ->:");scanf("%d",&scelta);
  switch(scelta)
	{
	case 1:{
	       cls();
	       mainins1();
	       break;
	       }
	case 2:{
	       cls();
	       mainins2();
	       break;
	       }
	case 3:{
	       cls();
	       mainins3();
	       break;
	       }
	case 4:{
	       cls();
	       mainins4();
	       break;
	       }
	case 5:{
	       cls();
	       mainins5();
	       break;
	       }
	case 6:{
	       cls();
	       mainins6();
	       break;
	       }
	case 0:{
	       cls();
	       mainins0();
	       break;
	       }
	default:break;
	}
 }
while(scelta);
}
