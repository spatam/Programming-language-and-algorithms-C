#include<stdio.h>
typedef struct tree *ptree;
typedef struct tree {int info;
		     ptree left,right;}stree;

ptree talloc();
void cls();
ptree getnode(ptree,int);
ptree insert(ptree,int);
void search(ptree,int);
void inorder(ptree);
void preorder(ptree);
void postorder(ptree);

ptree root,tree_a,tree_b;

main()
{
int j,t,w,m,i,x,y;
char c;

cls();
printf("\n=============================================================================\n");
printf("Inserire l'insieme A dei numeri\n");
printf("Quanti numeri ? ");scanf("%d",&m);
for(i=0;i<m;i++)
	{
	printf("Numero: ");scanf("%d",&x);
	insert(tree_a,x);
	}
printf("Inserire l'insieme B dei numeri\n");
printf("Quanti numeri ? ");scanf("%d",&w);
for(j=0;j<w;j++)
	{
	printf("Numero: ");scanf("%d",&y);
	insert(tree_b,y);
	}
printf("Vuoi ricercare qualche elemento ? (s/n) - ");getchar();
c=getchar();
if(c=='s')
	{
	printf("Quale elemento ricercare ? ");scanf("%d",&t);
	printf("\nRicerca in A -");search(tree_a,t);
	printf("\nRicerca in B -");search(tree_b,t);
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

ptree getnode(ptree root,int n)
{
ptree new=talloc();

new->info=n;
new->left=NULL;
new->right=NULL;
root=new;

return(root);
}

ptree insert(ptree root,int n)
{
if(root==NULL) getnode(root,n);
else if(n<root->info) root->left=insert(root->left,n);
else if(n>root->info) root->right=insert(root->right,n);

return(root);
}

void search(ptree root,int n)
{
if(root != NULL)
	{
	 if(n==root->info) printf("\nTrovato !!!!!!!!!!!!");
	 else if(n<root->info) search(root->left,n);
	 else search(root->right,n);
	}
else printf("\nElemento non trovato !!!!!!!!!!!!!!!!!!!!");
}

void inorder(ptree root)
{
if(root != NULL)
	{
	 inorder(root->left);
	 putchar(root->info);printf(",");
	 inorder(root->right);
	}
}

void postorder(ptree root)
{
if(root != NULL)
	{
	 postorder(root->left);
	 postorder(root->right);
	 putchar(root->info);printf(",");
	}
}

void preorder(ptree root)
{
if(root != NULL)
	{
	 putchar(root->info);printf(",");
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