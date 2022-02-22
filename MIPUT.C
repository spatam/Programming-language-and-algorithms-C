# include <stdio.h>
# include "def.h"

        /*  algoritmo MY_IPUT che rilascia un inode in memoria  */

	/*  INPUT  :  puntatore all'inode in memoria da rilasciare */
        /*  OUTPUT :  niente                                       */

   my_iput(node)
	   inodeptr node;
   {  
      node->rif_n --;     /* decrementa il reference count */
      if (node->rif_n == 0 ) /* se nessun file e' attivato all'inode */
      {
         if (node->stato == TRUE )
	   {            /* se il file e' stato modificato */
	    if ( node->in_disco.n_link == 0 )
	     {
	       free_blocchi(node->in_disco); /* si liberano i blocchi */
	       node->in_disco.tipo=NEW;   /* inizializzato l'inode */
	       my_ifree(node->inode_n);   /* si libera l'inode     */
	     }
	    i_write(node->in_disco,node->inode_n);  /* nodo su disco */
	   }                                          /*   aggiornato  */
      i_list(node);    /* il nodo e' inserito nella free_list */
      }
   }

   /* algoritmo MY_IFREE cha libera un inode dal disco   */
   /*   viene aggiornato il super blocco                 */

   /*  INPUT: numero di inode da liberare      */
   /*  OUTPUT:nessuno                          */

   my_ifree(number)
	    short number;
   {
      sb.n_ifree++;
      if (sb.next_i == 0)  /* lista nodi liberi piena */
	 {
	    if ( sb.l_ifree[F_LIST-1] > number )
		      sb.l_ifree[F_LIST-1]=number;
	 }
       else sb.l_ifree[--sb.next_i]=number; /* inserisce l'inode */
				/* nella lista degli inode liberi */
      sb.flag=TRUE;
   }
