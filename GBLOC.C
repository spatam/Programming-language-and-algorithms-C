# include <stdio.h>
# include "def.h"

 /* algoritmo MY_ALLOC : alloca un nuovo blocco dal file
			 system                       */
 /* INPUT : nessuno;
     OUTPUT: numero di buffer del nuovo blocco */

 long my_alloc()
 { 
   char buffer[SIZE_B];
   long *buf;
   long pos,num,n;
   int i;

   if ( sb.n_bfree == 0 ) {      /*  file system full  */
			   t_err=FLFS_ERR; 
			   return (-1);
                          }
   n=sb.l_bfree[sb.next_b];

   if ( sb.next_b == IND-1)     /* se e' l'ultimo blocco della lista */
    {		                /* contiene numeri di blocchi liberi */  
      b_read(buffer,n);    
      buf=(long *) buffer; 
      for (i=0;i<IND;i++)       /*  che vengono ricopiati  nella    */ 
      sb.l_bfree[i]=*(buf+i);   /*  lista del super blocco   */ 
      sb.next_b=-1;
     }
    sb.n_bfree--;
    sb.next_b++;
    sb.flag=TRUE;

    return n;
}

 /*  algoritmo MY_FREE : rilascia un blocco    */

 /* INPUT : numero di blocco da rilasciare */
 /* OUTPUT : nessuno                       */

     my_free(number)
	    long number;
     { 
	int i;
	long *buffer;

	sb.n_bfree++;
	if (sb.next_b == 0)  /* la lista dei blocchi liberi e' piena */
	   {
	     for (i=0;i<IND;i++)
	       *(buffer+i)=sb.l_bfree[i];
             b_write((char *) buffer,number);
             sb.next_b=IND-1;
	     sb.l_bfree[IND-1]=number;
           }
        else
	     sb.l_bfree[--sb.next_b]=number;
        sb.flag=TRUE;
    }


    /* algoritmo FREE_BLOCCHI che libera tutti gli blocchi della 
						table of content */

    /* INPUT  : inode i cui blocchi devono essere liberati */
    /* OUTPUT : nessuno                                    */

    free_blocchi(inod)
		st_dinode inod;
    {  
      long fine;
      long buffer[IND];
      int i; 
   
      fine=inod.size_f / SIZE_B;
      if (inod.size_f != (fine*SIZE_B)) fine++;

      for (i=0;((i<D_TABLE-1) && (i<fine));i++)
	  if (inod.table[i] != 0) {
	         my_free(inod.table[i]);
		 inod.table[i]=0L;
		}	 
      if (i<fine) {
		 b_read(buffer,inod.table[8]);
		 fine -= D_TABLE;
		 for (i=0;i<fine;i++)
		     if (buffer[i] != 0) my_free(buffer[i]);
                 inod.table[D_TABLE-1]=0L;
                  }
    }
