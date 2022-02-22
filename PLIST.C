# include <stdio.h>
# include "def.h"

   ptr_list()
   {
       int i=0;

       inodeptr node;

       printf("sono dentro ptr_list \n");

       for (i=0;i<MAXT;i++)
	  if (coda[i] != NULL)
		  { printf("\n posizione --> %4d * ",i);
		    for (node=coda[i];node != NULL;node=node->nx_code)
			printf("    %4d",node->inode_n);
                  }
       printf("\n");
       if (h_list == NULL ) printf(" lista vuota \n ");
       else
       {
         node=h_list;
         for (i=0;i<25;i++)
	  {
	    printf(" %d %d\n",node->inode_n,node->rif_n);
	    node=node->nx_list;
          }
	}  
	getchar();
    }

    sroot()
    {
      printf("entry 0 file table \n");
      printf("offset %d \n",f_table[0].offset);
      printf("mode %d \n",f_table[0].mode);
      printf("inode \n");
      scrivi(f_table[0].p_inode->in_disco);
      printf("numero %d \n",f_table[0].p_inode->inode_n);
      printf("ref_cont %d \n",f_table[0].p_inode->rif_n);
      getchar();
    }

    ftable()
    {
      int i;

      printf("stampa della f_table \n");
      for (i=0;i<next_entry;i++)
	printf("posizione %d valore %d \n",i,f_table[i].p_inode->inode_n);
    }
