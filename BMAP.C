# include "def.h"

  /* algoritmo MY_BMAPR che mappa blocchi derivanti dall'offset
	 logico in byte in blocchi del file system per letture  */

  /* INPUT  :inode,offset in byte;
  /* OUTPUT :numero blocco nel file system,
	     offset in byte nel blocco       */ 

    my_bmapr(inod,offset,nb,off_bl)
	    inodeptr inod;
            long offset;
	    long *nb;
	    long *off_bl;

   { 
     long buffer[IND];
     long nblocco;
     
     nblocco=offset/SIZE_B;
     *off_bl=offset-(nblocco*SIZE_B);

     if ( nblocco > D_TABLE-1 )
     {  
       b_read(buffer,inod->in_disco.table[D_TABLE-1]);
       nblocco-=D_TABLE;
       *nb=buffer[nblocco];
      }
      else *nb=inod->in_disco.table[nblocco];
    }































    /* algoritmo MY_BMAPW che mappa blocchi derivanti dall'offset in byte 
       per scritture nel file system e restituisce il blocco da scriver; 
       se necessario aggiorna la table of contenst dell'inode      */

   /*  INPUT :inode,offest in byte;
       OUTPUT :buffer per scrittura,offset in byte nel blocco    */ 

    my_bmapw(inod,offset,new_b,off_bl)
	     inodeptr inod;
	     long offset;
	     long *new_b;
	     long *off_bl;
   {
     long nblocco,new_b2;
     long buffer[IND];
     short i;

     nblocco=offset/SIZE_B;
     *off_bl=offset-(nblocco*SIZE_B);

     if (*off_bl != 0) my_bmapr(inod,offset,new_b,off_bl);

     if ((*off_bl == 0) || (*new_b == 0 ))

	       /* occorre un nuovo blocco */
       {  *new_b=my_alloc();

	  if ( nblocco < D_TABLE-1 ) 
	           inod->in_disco.table[nblocco]=*new_b;
               else
	           if (nblocco == D_TABLE-1 ){
		         new_b2=my_alloc;
		         inod->in_disco.table[nblocco]=new_b2;
		         buffer[0]=*new_b;
			 for (i=1;i<IND;i++) buffer[i]=0L; 
		         b_write(buffer,new_b2);
                          }
                       else    /*  nblocco > D_TABLE-1  */
	                {
		          b_read(buffer,inod->in_disco.table[D_TABLE-1]);
		          nblocco-=D_TABLE;
	                  buffer[nblocco]=*new_b;
		          b_write(buffer,inod->in_disco.table[D_TABLE-1]);
		        }
          inod->stato=TRUE;
        }
   }

