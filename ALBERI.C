#include<stdio.h>
typedef struct tree *ptree;
typedef struct tree {
	int info;
	ptree left,right;
}stree;

ptree talloc();
void cls();
void getnode(ptree *,int);
void insert(ptree *,int);
ptree search(ptree,int);
void inorder(ptree);
void preorder(ptree);
void postorder(ptree);

main()
{
int j,t,w,m,i,x,y;
char c;
ptree root=NULL,tree_a=NULL,tree_b=NULL;

cls();
printf("\n=============================================================================\n");
printf("Inserire l'insieme A dei numeri\n");
printf("Quanti numeri ? ");scanf("%d",&m);
for(i=0;i<m;i++)
	{
	printf("Numero: ");scanf("%d",&x);
	insert(&tree_a,x);
	}
printf("Stampa albero A inorder -> ");inorder(tree_a);printf("\n");

printf("Inserire l'insieme B dei numeri\n");
printf("Quanti numeri ? ");scanf("%d",&w);
for(j=0;j<w;j++)
	{
	printf("Numero: ");scanf("%d",&y);
	insert(&tree_b,y);
	}
printf("Stampa albero B inorder -> ");inorder(tree_b);printf("\n");

printf("Vuoi ricercare qualche elemento ? (s/n) - ");getchar();
c=getchar();
if(c=='s')
	{
	printf("Quale elemento ricercare ? ");scanf("%d",&t);
	printf("\nRicerca in A -");
	if (search(tree_a,t)!=NULL) printf("TROVATO !!!!! in A");
			     else printf("NON TROVATO !!! in A");
	printf("\nRicerca in B -");
	if (search(tree_b,t)!=NULL) printf("TROVATO !!!!! in B");
			     else printf("NON TROVATO !!! in B");
	}
else printf("Nessuna ricerca effettuata\n");
printf("\nInorder di A: ");inorder(tree_a);
printf("\nInorder di B: ");inorder(tree_b);
printf("\nPreorder di A: ");preorder(tree_a);
printf("\nPreorder di B: ");preorder(tree_b);
printf("\nPostorder di A: ");postorder(tree_a);
printf("\nPostorder di B: ");postorder(tree_b);
scanf("\n");
}

ptree talloc()
{
return (ptree)malloc(sizeof(stree));
}

void getnode(ptree *r,int n)
{
ptree root=*r;
ptree new=talloc();

new->info=n;
new->left=NULL;
new->right=NULL;
root=new;

*r=root;
}

void insert(ptree *r,int n)
{
ptree root=*r;

if(root==NULL) getnode(&root,n);
else if(n<root->info) insert(&(root->left),n);
else if(n>root->info) insert(&(root->right),n);

*r=root;
}

ptree search(ptree root,int n)
{
if(root != NULL)
	{
	 if (n==root->info) return root;
	 else if(n<root->info) search(root->left,n);
			  else search(root->right,n);
	}
else return NULL;
}

void inorder(ptree root)
{
if(root != NULL)
	{
	 inorder(root->left);
	 printf("%d ",root->info);
	 inorder(root->right);
	}
}

void postorder(ptree root)
{
if(root != NULL)
	{
	 postorder(root->left);
	 postorder(root->right);
	 printf("%d ",root->info);
	}
}

void preorder(ptree root)
{
if(root != NULL)
	{
	 printf("%d ",root->info);
	 preorder(root->left);
	 preorder(root->right);
	}
}

void cls()
{
int i;

for(i=0;i<30;i++) printf("\n");
}

