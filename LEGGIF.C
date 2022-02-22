# include <stdio.h>
# include <fcntl.h>
# include <time.h>
# include "def.h"

st_dinode inode;

    leggi()
  {     
	long numero,pos;
	int  i;

	getchar();
	printf("flag %d \n",sb.flag);
	printf("dim_f %ld \n",sb.dim_f);
	printf("dim_li %ld \n",sb.dim_li);
	printf("n_ifree %d\n",sb.n_ifree);
	printf("next_i %d \n",sb.next_i);
	for (i=0;i<10;i++)
		printf("l_ifree %d %d ",i,sb.l_ifree[i]);
	printf("\n");
	printf("n_bfree %d \n",sb.n_bfree);
	printf("next_b %d \n",sb.next_b);
	getchar();
	for (i=0;i<IND;i++)
		printf(" %ld ",sb.l_bfree[i]);
	printf("\n");
	getchar();
	printf("vuoi stampati la blocc_list 1:si ");
	scanf("%d",&i);
        if (i == 1) b_list();
	printf("vuoi stampati la inode_list 1:si ");
	scanf("%d",&i);
	if (i == 1) in_list();
  }
     
     in_list()
       {
	int i;
	long numero;

	printf("sono dentro inlist \n");
	for (i=0;i<NFILE;i++)
	  { 
	    i_read(&inode,i+1);
	    scrivi(inode);
	  }
       }

  scrivi(root)
	 st_dinode root; 
   {
	char *data;

	printf("proprietari %d %d \n",root.uid,root.gid);
	printf("tipo e permessi di accesso %d %d \n",root.tipo,root.perms);
	data=asctime(localtime(&root.atime));
	printf("data ultimo accesso %s \n",data);
	getchar();
   }

   b_list()
   {    
	long pos,num,n;
	int i;
	char buf[SIZE_B];
	long *buffer;

	printf("sono dentro b_list \n");

	n=sb.l_bfree[IND-1];
        
	printf("n vale %ld \n",n);
	while (n < N_BLOC)
	{
	  printf("n vale %ld \n",n);
	
	  b_read(buf,n);

          buffer=(long *) buf;

	  for (i=0;i<IND;i++)
		printf(" %ld ",*(buffer+i));
          printf("\n");
          n=*(buffer+IND-1);
	  getchar();
        } 
    }
