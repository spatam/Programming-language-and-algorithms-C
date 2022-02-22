# include <stdio.h>

   int *insert(int *n);
   void insertion_sort(int *s,int n);
   void stampa(int *s,int n);

main()
{  char scelta;
   int *s,n;

  do {
    /* rewind(stdin); */
    s=insert(&n);
    insertion_sort(s,n);
    stampa(s,n);

    printf("\n Vuoi continuare ? ");getchar();
    scelta=getchar();
    free(s);
    }
  while (scelta == 's');
}

void insertion_sort(s,n)
     int *s;
     int n;
{
  int i,j,key;

  printf("%d \n",n);
  for ( j = 1 ;j <= n-1; j++ )
  {
      key = s[j];
      i = j-1;
      while ( i >= 0 && s[i] > key )
      {
	   s[i+1] = s[i];
	   i = i -1;
      }
      s[i+1]=key;
  }
}

int *insert(n)
     int *n;
{
  int i,j,*s;

  printf("\n Quanti numeri vuoi inserire ? ");
  scanf("%d",n);
  s=(int *) calloc (n,sizeof(n));
  for (i=0; i < *n; i++)
  {
      printf("\n Numero : ");
      scanf("%d",&j);
      s[i] = j;
  }
  return s;
}
void stampa(s,n)
     int *s,n;
{
 int i;

 printf("\n");
 for (i=0;i<n; i++) printf("%d ",s[i]);
 printf("\n");
}
