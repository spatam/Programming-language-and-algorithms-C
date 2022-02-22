# include <stdio.h>
# include "def.h"

  /*  Algoritmo MY_CREAT :  crea un nuovo file , se esiste lo tronca */

  /*  INPUT  : nome del file ( PATH )
	       permessi di accesso ( PERM )
      OUTPUT : descrittore del file         */

     int my_creat(path,perm)
		   char *path;
		   short perm;
    {
      long offset,n,nb,pos;
      inodeptr new,father;
      int i,j,fine,next;
      st_dir entry;
      char buffer[SIZE_B];

      new=my_name(path);

      if ((t_err == NOT_ERR) && (new->in_disco.tipo != REGULAR)) 
						       t_err=FDIR_ERR;
      if ( (t_err != FNFD_ERR) && (t_err != NOT_ERR)) {
						my_iput(new);
						return (-1);
						}
      if  (t_err == FNFD_ERR)    /* il file non esiste */
	{
	 father=new;        /* directory padre del nuovo file */
	 new=my_ialloc(REGULAR);   /* alloca un inode nuovo */
	 if (new==NULL) return(-1);

	/* crea una entry nella directory di appartenenza */

	 my_bmapw(father,father->in_disco.size_f,&nb,&offset);

	 if (offset != 0) b_read(buffer,nb);
	 entry.inode_n=new->inode_n;
	 strcpy(entry.nome,path);
         memcpy(&(buffer[offset]),&entry,sizeof(entry)); 
	 b_write(buffer,nb);

	 father->in_disco.size_f +=16;
	 father->stato=TRUE;
	 my_iput(father);
	}
       else 	        /* il file esiste */
	{  
	   if ((new->rif_n == 1) && (new->in_disco.n_link == 1)) 
	      { new->in_disco.size_f=0;
	        free_blocchi(new->in_disco);   /* il file viene troncato */
              } 
	   else { 
                 t_err=FNTR_ERR;
		 return (-1);
                } 
           new->stato=TRUE;
	}



      if ((next=search_entry()) == -1) return (-1);
      f_table[next].count=1;
      f_table[next].offset=0;
      f_table[next].mode=OPEN_W;
      f_table[next].p_inode=new;

   return (next); 
  }
