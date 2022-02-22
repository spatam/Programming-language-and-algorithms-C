# include <stdio.h>
# include "def.h"

	/*  algoritmo miget che alloca una copia in memoria di un inode */

	/*  INPUT:   numero di inode da leggere  */
	/*  OUTPUT : inode in memoria            */

 inodeptr my_iget(number_i)
	       short number_i;
 {
      long pos,number;
      int mod;
      st_dinode inode;
      inodeptr nodo;

      mod=number_i % MAXT;

	    /* cerca l'inode nella relativa coda */

 for(nodo=coda[mod];((nodo != NULL)&&(nodo->inode_n != number_i));nodo=nodo->nx_code);

      if (nodo != NULL) {
		/*  inode nella coda in memoria   */

          if ( nodo->rif_n == 0 )        /* inode nella free list */
               d_list(nodo);        /* delete nodo dalla free list */
         
	  nodo->rif_n ++ ;   /* incremento il reference count */

	  return (nodo);
	}
      else {
		/*   inode non e' nella coda cache in memoria */
	  
	  if ( h_list == NULL ){ 
		t_err=LFUL_ERR;        /*    free list vuota    */
		return (nodo);
		}
          else {
	    nodo=h_list;
	    d_list(nodo);
            d_code(nodo);
	    nodo->inode_n=number_i; 
	    i_code(nodo);
	    i_read(&inode,number_i);
 	    nodo->in_disco=inode;
	    nodo->rif_n=1;

	    return(nodo);
	  }
	}
}
