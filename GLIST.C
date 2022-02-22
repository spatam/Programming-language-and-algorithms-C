# include <stdio.h>
# include "def.h"

	/*  procedura che inserisce un inode nella free list  */

    i_list(node)
	   inodeptr node;
    {     
	  if ( h_list == NULL ) 
		     h_list=node->nx_list=node->lt_list=node;
          else
	  {
	       node->nx_list=h_list; 
	       node->lt_list=h_list->lt_list;
	       h_list->lt_list->nx_list=node;
	       h_list->lt_list=node;
          }
     }

      /*   procedura che inserisce un inode nella free list */

    d_list(node)
	   inodeptr node;
    {     
	  if (h_list == h_list->nx_list) h_list=NULL;
	  else
	    {  
              node->lt_list->nx_list=node->nx_list;
              node->nx_list->lt_list=node->lt_list;
	      if ( node == h_list) h_list=node->nx_list;
            }
    }

     /*    procedura che inserisce un inode nella coda hash  */

    i_code(node)
	   inodeptr node;
    {  
       int mod;
       mod=node->inode_n % MAXT;
       
       node->nx_code=coda[mod];
       if ( coda[mod] != NULL )  coda[mod]->lt_code=node;
       coda[mod]=node;
    }

    /*     procedura che delete un inode nella coda hash */

    d_code(node)
	  inodeptr node;
    {
	  int mod;
          mod=node->inode_n % MAXT; 

	  if (coda[mod] == node ) coda[mod]=node->nx_code;
			   else   node->lt_code->nx_code=node->nx_code;
          if (node->nx_code != NULL )
			    node->nx_code->lt_code=node->lt_code;
    }
