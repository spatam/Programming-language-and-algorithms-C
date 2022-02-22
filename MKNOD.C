# include <stdio.h>
# include "def.h"

  /*  Algoritmo MY_MKNOD :  crea directory */

  /*  INPUT  : nome della directory  ( PATH )
	       permessi di accesso ( PERM )
      OUTPUT : descrittore del file         */

      my_mknod(path,perm)
		   char *path;
		   short perm;
    {
      long offset,n,nb,pos;
      inodeptr new,father;
      st_dir entry[2];
      char buffer[SIZE_B];

      new=(inodeptr) malloc(sizeof(new));

      new=my_name(path);

      if  (t_err == FNFD_ERR)    /* il file non esiste */
	{
	 father=new;        /* directory padre del nuovo file */

	 new=my_ialloc(DIR);   /* alloca un inode nuovo */

	 if (new==NULL) return(-1);

	/* crea una entry nella directory di appartenenza */

	 my_bmapw(father,father->in_disco.size_f,&nb,&offset);

	 if (offset != 0) b_read(buffer,nb);
	 entry[0].inode_n=new->inode_n;
	 strcpy(entry[0].nome,path);
	 memcpy(&(buffer[offset]),&entry[0],16); 
	 b_write(buffer,nb);

	 father->in_disco.size_f +=16;
	 father->stato=TRUE;

	 nb=my_alloc();
	 entry[0].inode_n=new->inode_n;
	 strcpy(entry[0].nome,"."); 
	 entry[1].inode_n=father->inode_n;
	 strcpy(entry[1].nome,"..");
	 memcpy(buffer,&entry,32);
	 b_write(buffer,nb);

	 new->in_disco.size_f =32;
	 new->in_disco.table[0]=nb;   
	 new->stato=TRUE;           

	 my_iput(father);
	}

      my_iput(new);
 }

   
   /*  Algoritmo MY_CHDIR : cambia la directory corrente  */

   int my_chdir(path)
	    char *path;
   {
     inodeptr n_dir;

     n_dir=my_name(path);
     
     my_iput(n_dir);
     if ((t_err == NOT_ERR) && (n_dir->in_disco.tipo != DIR) )
			       t_err=FNFD_ERR;
     if (t_err == NOT_ERR) 
	   return(n_dir->inode_n);
       else return(-1);
   } 
