#include<stdio.h>

int insert(char **attivita,int *s,int *f)
{
int n,i;

printf("\n###################INSERIMENTO#######################\n");
printf("\nQuante attivita' vuoi inserire ? ");scanf("%d",&n);
attivita=(char **)calloc(n,sizeof(char));
s=(int *)calloc(n,sizeof(int));
f=(int *)calloc(n,sizeof(int));
for(i=0;i<n;i++)
	{
	printf("\nInserisci un attivita' : ");
	rewind(stdin);gets(&attivita[i]);
	printf("\nOra inizio: ");scanf("%d",&s[i]);
	printf("\nOra fine  : ");scanf("%d",&f[i]);
	}

return n;
}

void insertion_sort(int *f,int n)
{
int i,j,key;

for(j=1;j<n-1;j++)
	{
	key=f[j];
	i=j-1;
	while(i>0 && f[i]>key)
		{
		f[i+1]=f[i];
		i=i-1;
		}
	f[i+1]=key;
	}
}

char **greedy_activity_selector(int *s,int *f,int n,char **attivita)
{
int j,i;

attivita=attivita[1];
j=1;
for(i=1;i<n;i++)
 if(s[i]>=f[i])
	{
	insertion_sort(f[i],n);
	j=1;
	}

return (attivita);
}

main()
{
int n,i;
int *s,*f;
char **attivita;

n=insert(attivita,s,f);
attivita=greedy_activity_selector(s,f,n,attivita);
printf("\nSTAMPA:   ATTIVITA' - ORA inizio - ORA fine *************");
for(i=0;i<n;i++) printf("%s        %d          %d",attivita[i],s[i],f[i]);
scanf("\n");
}