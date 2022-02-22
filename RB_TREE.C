#include<stdio.h>
#include<ctype.h>

typedef struct ptree *ptree;
typedef struct ptree
		   {
		   char color;
		   int key;
		   ptree left;
		   ptree right;
		   ptree p;
		   }stree;

ptree nilt;  /*Questa variabile Š di tipo sentinella,il suo compito Š di*/
ptree root;  /*sostituire il puntatore vuoto NULL si utilizza nella*/
int timet;   /*procedura delete*/
int number,key,totimet;

/*questa procedure serve per predisporre l'utilizzo della sentinella nilt*/
/*il suo utilizzo Š reso necessario perchŠ:1)le foglie NULL devono essere*/
/*nere2)Nella delete Š richiesta la possibilit… di risalire da una foglia*/
/*NULL al diretto predecessore*/

void s_nilt()
{
extern ptree root,nilt;

nilt=(ptree)malloc(sizeof(stree));
nilt->key=0;
nilt->color='0';
nilt->right=NULL;
nilt->left=NULL;
nilt->p=NULL;
root=nilt;
}

void cls()
{
int i;

for(i=0;i<30;i++) printf("\n");
}

ptree alloctree(info)
int info;
{
extern ptree nilt;
ptree new;

new=(ptree)malloc(sizeof(stree));
new->key=info;
new->color='1';
new->left=nilt;
new->right=nilt;
new->p=nilt;

return (new);
}

/*questa proc alloca un nodo in memoria di tipo ptree e di dimensione stree*/

void cartree(nkey)
int nkey;
{
ptree node;
void treeinsert(ptree);

node=alloctree(nkey);
treeinsert(node);
}

void inorder(node)
ptree node;
{
extern ptree nilt;

if(node != nilt)
	{
	inorder(node->left);
	printf("\n %4d",node->key);
	if(node->color=='1') printf(" rosso");
	else printf(" nero");
	inorder(node->right);
	}
}

void mprint()
{
extern ptree root;

printf("\n  * STAMPA ORDINATA DELLA STRUTTURA RED_BLACK TREE * \n");
inorder(root);
}

/*procedura rotazione a sinistra*/

void leftrotate(node)
ptree node;
{
extern ptree root,nilt;
extern int timet;
ptree anode;

timet+=3;
anode=node->right;
node->right=anode->left;
if(anode->left != nilt)
	{
	anode->left->p=node;
	timet++;
	}
timet+=5;
anode->p=node->p;
if(node->p==nilt) root=anode;
else
	{
	if(node==node->p->left) node->p->left=anode;
	else node->p->right=anode;
	timet++;
	}
anode->left=node;
node->p=anode;
}

/*procedura rotazione a destra*/

void rightrotate(node)
ptree node;
{
extern ptree root,nilt;
extern int timet;
ptree anode;

timet+=3;
anode=node->left;
node->left=anode->right;
if(anode->right != nilt)
	{
	anode->right->p=node;
	timet++;
	}
timet+=5;
anode->p=node->p;
if(node->p==nilt) root=anode;
else
	{
	if(node==node->p->right) node->p->right=anode;
	else node->p->left=anode;
	timet++;
	}
anode->right=node;
node->p=anode;
}

/*procedura per il ripristino della propriet… 4:in tutti i cammini */
/*nodo-foglia c'Š lo stesso numero di nodi interni*/

void rb_delete_fixup(x)
ptree x;
{
extern ptree root;
extern int timet;
ptree w;

while(x !=root && x->color=='0')
	{
	timet+=2;
	if(x==x->p->left)
		{
		timet+=2;
		w=x->p->right;
		if(w->color=='1')
			{
			w->color='0';
			x->p->color='1';
			timet+=3;
			leftrotate(x->p);
			w=x->p->right;
			}
		timet++;
		if(w->left->color=='0' && w->right->color=='0')
			{
			w->color='1';
			x=x->p;
			timet+=2;
			}
		else
			{
			timet++;
			if(w->right->color=='0')
				{
				w->left->color='0';
				w->color='1';
				rightrotate(w);
				timet+=3;
				w=x->p->right;
				}
			w->color=w->p->color;
			x->p->color='0';
			w->right->color='0';
			leftrotate(x->p);
			x=root;
			timet+=4;
			}
		}
	else /*casi simmetrici*/
		{
		timet+=2;
		w=x->p->left;
		if(w->color=='1')
			{
			w->color='0';
			x->p->color='1';
			timet+=3;
			rightrotate(x->p);
			w=x->p->left;
			timet+=3;
			}
		timet++;
		if(w->right->color=='0' && w->left->color=='0')
			{
			w->color='1';
			x=x->p;
			timet+=2;
			}
		else
			{
			timet++;
			if(w->left->color=='0')
				{
				w->right->color='0';
				w->color='1';
				leftrotate(w);
				w=x->p->left;
				timet+=3;
				}
			w->color=w->p->color;
			x->p->color='0';
			w->left->color='0';
			rightrotate(x->p);
			x=root;
			timet+=4;
			}
		}
	}
x->color='0';
timet+=2;
}

/*procedura inserimento*/

void inserx(node)
ptree node;
{
extern ptree root,nilt;
extern int timet;
ptree prec,anode;

prec=nilt;
anode=root;
timet +=3;
while(anode != nilt)
	{
	timet+=4;
	prec=anode;
	anode=(node->key < anode->key) ? anode->left:anode->right;
	}
timet+=3;
node->p=prec;
if(prec==nilt) root=node;
else
	{
	timet++;
	if(node->key<prec->key) prec->left=node;
	else prec->right=node;
	}
}

/*questa proc riceve in input un nodo ptree che contiene nel key l'elemento*/
/*da inserire e lo concatena al rb_tree*/

void treeinsert(node)
ptree node;
{
extern int timet;
extern ptree root;
ptree znode;

inserx(node);
timet++;
while((node != root) && ((node->p->color)=='1'))
	{
	timet+=2;
	if(node->p==node->p->p->left)
		{
		znode=node->p->p->right;
		if(znode->color=='1')
			{
			timet+=4;
			node->p->color='0';
			znode->color='0';
			node->p->p->color='1';
			node=node->p->p;
			}
		else
			{
			timet++;
			if(node==node->p->right)
				{
				timet++;
				node=node->p;
				leftrotate(node);
				}
			node->p->color='0';
			node->p->p->color='1';
			timet+=2;
			rightrotate(node->p->p);
			}
		}
		else    /*casi simmetrici*/
			{
			timet+=2;
			znode=node->p->p->left;
			if(znode->color=='1')
				{
				timet+=4;
				node->p->color='0';
				znode->color='0';
				node->p->p->color='1';
				node=node->p->p;
				}
			else
				{
				timet++;
				if(node==node->p->left)
					{
					timet++;
					node=node->p;
					rightrotate(node);
					}
				timet+=2;
				node->p->color='0';
				node->p->p->color='1';
				leftrotate(node->p->p);
				}
			}
	}
timet++;
root->color='0';
}

/*funzione per la ricerca in rb_tree*/

ptree rb_search(k)
int k;
{
extern ptree root;
extern int timet;
ptree x=root;

while((x != nilt) && (k != x->key))
	{
	x=(k<x->key) ? x->left : x->right;
	timet+=3;
	}
return x;
}

/*ricerca del minimo*/

ptree rb_minimum(x)
ptree x;
{
extern int timet;

while(x->left != nilt)
	{
	x=x->left;
	timet+=2;
	}
return x;
}

/*procedura che elimina il nodo che contiene la chiave num*/

void rb_delete(num)
int num;
{
extern ptree root,nilt;
extern int timet;
ptree x,y,z;

z=rb_search(num);
timet++;
if(z !=nilt)
	{
	timet+=2;
	y=(z->left==nilt || z->right==nilt) ? z:rb_minimum(z->right);
	x=(y->left != nilt) ? y->left : y->right;
	timet+=2;
	x->p=y->p;
	timet+=3;
	if(y->p==nilt) root=x;
	else
		{
		if(y==y->p->left) y->p->left=x;
		else y->p->right=x;
		timet++;
		}
	if(y != z)
		{
		z->key=y->key;
		timet++;
		}
	if(y->color=='0') rb_delete_fixup(x);
	free(y);
	timet+=2;
	}
else printf("\n Elemento inesistente nella struttura rb_tree \n");
}

void tempo()
{
extern int timet;

printf("\nTempo di esecuzione con ALBERI ROSSO-NERI--> %4d\n",timet);
timet=0;
}

void mainins()
{
int nkey;
char ris;

printf("      ****************************INSERIMENTO**********\n");
do
{
	printf("\nNumero: ");
	rewind(stdin);scanf("%d",&nkey);
	cartree(nkey);
	number++;
	totimet+=timet;
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
ptree nodetree;

cls();
timet=totimet=number=0;
s_nilt();
do
 {
 printf("\n\n\n");
 printf("*** MANIPOLAZIONE DI INSIEMI TRAMITE RED-BLACK TREE ***\n\n");
 printf("==========================MENU'==========================\n");
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
	       rewind(stdin);
	       mainins();
	       break;
	       }
	case 2:{
	       cls();
	       printf("\n**********************RICERCA******************\n");
	       printf("\nQuale elemento vuoi cercare ? :");
	       rewind(stdin);
	       scanf("%d",&key);
	       nodetree=rb_search(key);
	       if(nodetree != nilt)
		printf("\nElemento: %d presente nel RB-TREE !\n",key);
	       else
		printf("\nElemento: %d non presente nel RB-TREE !\n",key);
	       totimet+=timet;
	       tempo();
	       break;
	       }
	case 3:{
	       cls();
	       printf("\n**********************DELETE*******************\n");
	       printf("\nQuale elemento vuoi eliminare ? ->");
	       rewind(stdin);
	       scanf("%d",&key);
	       rb_delete(key);
	       printf("\nElemento ->%d eliminato.\n",key);
	       totimet+=timet;
	       number--;
	       tempo();
	       break;
	       }
	case 4:{
	       cls();
	       rewind(stdin);
	       mprint();
	       break;
	       }
	default:break;
	}
 }
while(scelta);
tempo();
}