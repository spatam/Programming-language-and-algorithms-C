# include <stdio.h>
# include <fcntl.h>
# include "def.h"

  main() {
   int siz,f;

   inode_core();  /* inizializza l'inode_core : la struttura dati
	           in memoria che conterra' la copia degli inode */ 

   init_core(); /* legge dal disco il super blocco e la root */
  
   server(); 
   chiudi();
  }  

  /*   procedura  che  alloca in memoria la free list e la hash code    */
  /*     per gestire l'inode_core                                       */

  inode_core()
  {
      short i;
      inodeptr newnode;
      
      h_list=NULL;
      for (i=0;i<MAXT;i++)
	  coda[i]=NULL;

      for (i=NFILE+1;i< NFILE+1+MAXF;i++)
	  {
	      newnode=(inodeptr) malloc(sizeof(st_inode));
              
	      newnode->stato=FALSE;
	      newnode->inode_n=i;
	      newnode->rif_n=0;
  newnode->nx_code=newnode->lt_code=newnode->nx_list=newnode->lt_list=NULL;

	      i_list(newnode);
	      i_code(newnode);
	  }
    }


















   
   /*  procedura che carica dal disco il super blocco e la radice del
	file system                                              */		 

    init_core()
    {
      long num,pos;
     
     fd=open("fs.dat",O_RDWR);
     if (fd == -1)
	    { printf("errore nell'apertura del file system \n");
	      exit();
            }

	    /*  leggge il super blocco dal disco     */

     num=read(fd,&sb,sizeof(sb));
 
	/* inizializza la root in memoria definenedo le entry nella
	   file table e inode_core                                */

     f_table[0].offset=0;
     f_table[0].mode=O_RDWR;
     f_table[0].p_inode=root=my_iget(1);
     dir_cor=1;
     next_entry=0;
    }

    chiudi()
    { 
      inodeptr node;
      long number,i;

      if ( sb.flag == TRUE )
	{ 
	  sb.flag=FALSE;
	  number=lseek(fd,0L,0);
	  number=write(fd,&sb,sizeof(sb));
        }
      for (i=0;i<MAXT;i++) 
	    for(node=coda[i];node != NULL;node=node->nx_code)
	       if (node->rif_n != 0) 
			  my_iput(node);
    } 
