# include <stdio.h>
# include <fcntl.h>
# include "def.h"

  st_dinode inode;   /* struttura inode su disco */

  main() {
   int siz;

   fd=creat("fs.dat",PERMS);
   if ( fd == -1 )
      { printf("errore nella creazione del file system \n");
	exit();
      } 
	 
   init();         /* inizializza il superblocco del f_s */ 
   inode_list();  /* inizializza la lista degli inode   */
   blfree_list(); /* inizializza la lista dei blocchi liberi */

   close(fd);
  }  

  /*  procedura che inizializza il super blocco  */  

    init()
   {
	long numero,pos;
	int  i;

	sb.flag=FALSE;
	sb.dim_li=NFILE*sizeof(inode);
	sb.dim_f=sizeof(sb)+sb.dim_li+N_BLOC;
	sb.n_ifree=NFILE-1;
	sb.next_i=0;
	for (i=0;i<10;i++)
		sb.l_ifree[i]=i+2;
	sb.n_bfree=N_BLOC;
	sb.next_b=0;
	for (i=0;i<IND;i++)
		sb.l_bfree[i]=i+1;
        
	numero=write(fd,&sb,sizeof(sb));
	if ( numero == -1)
	      {   printf("errore nella scrittura del file system \n");
		  exit(1);
	      }
}













 /*  procedura che inizializza la lista degli inode nel file 
     system; vengono settati tutti i campi TIPO_FILE = NEW  
     e la table of content= 0;
     Per la ROOT ( inode 1) vengono inizializzati tutti i 
     campi e posto TIPO_FILE = DIR                         */

  inode_list()
  {
    short i;
    long number;
    
    set_inode(&inode,DIR); /* viene settata la ROOT del file system */ 
    i_write(inode,1);         /* viene scritta su disco           */

           /*  vengono inizializzati gli altri inode su disco  */

    inode.tipo=NEW; 
    for (i=0;i<9;i++) inode.table[i]=0;

    for (i=0;i<NFILE-1;i++)
		number=write(fd,&inode,sizeof(inode));
  }

  /*  procedura che inizializza la lista dei blocchi liberi 
      nel super blocco                              */

   blfree_list()
   {
      long tab[IND];  /* blocco logico: 'ind' numeri di blocchi */ 
      int n_blocchi;  /* numero di blocchi necessari per 
			 contenere la lista linkata          */

      long num_blocco=IND;   /* contatore dei blocchi liberi   */ 
               
           /*  IND : numero di indirizzi per blocco   */
	      
      int i,j;
      long n;      

      n_blocchi=N_BLOC/IND;

      n=IND;

      for (i=0;i<n_blocchi;i++)
	 {
	   for (j=0;j<IND;j++)
	       tab[j]=++num_blocco;

	   b_write((char *) tab,n); 
	   n=tab[IND-1];
	 }
    }
