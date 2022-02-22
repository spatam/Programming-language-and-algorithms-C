# include <stdio.h>
# include "def.h"

  /*   algoritmo MY_IALLOC che assegna nuovi inode  */

  /*  INPUT  : nessuno   */
  /*  OUTPUT : nuovo inode */

   inodeptr my_ialloc(tipo_file) 
                      short tipo_file;  
   {
      short i,indice;
      inodeptr new_inode;
      st_dinode inode;

	  /*  sb : struttura del super _blocco (var globale) */
      
      if ( sb.n_ifree == 0 ){       /* non ci sono inode liberi nel */
			     t_err=FMAX_ERR;
			     return(NULL);      /*    file system     */
                            }
      if ( sb.next_i == F_LIST )
	{
	 /*   lista degli inode liberi nel superblocco vuota  */

	 i=0;
	 indice=sb.l_ifree[sb.next_i-1];
	 while ((i < 10) & (i < sb.n_ifree))
	   {
	     i_read(&inode,indice);
	     if ( inode.tipo == NEW )
			   sb.l_ifree[i++]=indice;
	     indice++;
	   }
	 sb.next_i=0;
	 sb.flag=TRUE;
	}
       /* la lista degli inode liberi nel s_blocco non e' vuota */

	 new_inode=my_iget(sb.l_ifree[sb.next_i]);
	 if (new_inode != NULL )
	    {
	      set_inode(&(new_inode->in_disco),tipo_file);
              i_write(new_inode->in_disco,new_inode->inode_n);

	      sb.next_i++;
	      sb.n_ifree--;
	      sb.flag=TRUE;
	    }
	 return(new_inode);
   }
