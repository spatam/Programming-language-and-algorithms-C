# include <stdio.h>

typedef struct lista *plista;
typedef struct lista {
	char info;
	plista next;
}slista;

plista initlist();
void stampals(plista);
plista ordina(plista);
plista push(plista,char);
plista ins_ord(plista,char);
void semplifica(plista);

main()
{
 plista head=NULL,t=NULL;

 head=initlist();
 printf("lista inserita ->>> ");
 stampals(head);
 t=ordina(head);
 printf("lista ordinata ->>> ");
 stampals(t);

 semplifica(t);
 printf("Lista semplificata ->>> ");
 stampals(t);printf("\n");
 scanf("\n");
}

void ins_coda(plista *h,plista *t,char c)
{
  plista new=(plista)malloc(sizeof(*new));
  plista head=*h,tail=*t;

  new->info=c;
  new->next=NULL;

  if (head==NULL) head=new;
  else tail->next=new;
  tail=new;

  *h=head;
  *t=tail;
}

plista initlist()
{
 char s[100];
 char *p=s;
 plista head=NULL,tail=NULL;

 printf("Inserisci una stringa: ");gets(s);
 while (*p != '\0') {
     ins_coda(&head,&tail,*p);
     p++;
  }
  return head;
}

void stampals(plista h)
{
 while (h!=NULL)
 {  putchar(h->info);
    h=h->next;
 }
 printf("\n");
}

plista push(plista head,char x)
{
  plista new=(plista)malloc(sizeof(*new));

  new->info=x;
  new->next=head;
  head=new;

  return (head);
}

plista ins_ord(plista head,char x)
{
  if (head==NULL || x<head->info) head=push(head,x);
  else head->next=ins_ord(head->next,x);

  return (head);
}

plista ordina(plista head)
{
 plista newh=NULL;

 while (head !=NULL) {
   newh=ins_ord(newh,head->info);
   head=head->next;
 }

 return (newh);
}

void semplifica(plista head)
{
 plista x;

 while(head !=NULL && head->next !=NULL) {
  while(head->info==(head->next)->info){
	x=head->next;
	head->next=(head->next)->next;
	free(x);
       }
  head=head->next;
 }
}