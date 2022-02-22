# include <stdio.h>
# include "def.h"

  long dim_sb=sizeof(sb);

  /*  procedura che legge un inode dal disco e lo trasferisce */
  /*  nella realativa struttura                               */

  /* INPUT  : numero di inode da leggere                  */
  /* OUTPUT : la struttura con l'inode richiesto          */

  i_read(inode,num_inode)
	    struct dinode *inode; 
	    short num_inode;
  {  
     long number=dim_sb + (num_inode -1)*sizeof(*inode);

     number=lseek(fd,number,0);
     if ( number == -1) { t_err=LSEK_ERR; 
		          return;
			} 
     number=read(fd,inode,sizeof(*inode));
     if ( number == -1) { t_err=READ_ERR;
			  return;
			} 
  }

  /*  procedura che scrive un inode sul disco */

  /* INPUT  : inode da scrivere               */
  /* OUTPUT : nessuno                        */
 
  i_write(inode,num_inode)
	    st_dinode inode; 
	    short num_inode;
  {
     long number=dim_sb + (num_inode -1)*sizeof(inode);

     number=lseek(fd,number,0);
     if ( number == -1){ 
		     t_err=LSEK_ERR;
		     return;
                    }
     number=write(fd,&inode,sizeof(inode));
     if ( number == -1){
		     t_err=WRIT_ERR;
	             return;
		     }
  }











  /* procedura che legge un blocco di dati 
				 dal file system */

  /* INPUT :numero di blocco da leggere  */
  /* OUTPUT : buffer contenente i dati   */

        b_read(buffer,number)
	       char buffer[SIZE_B];
	       long number; 
     {  
	long num,i;
	long pos=dim_sb + sb.dim_li + (number-1)*SIZE_B;
	
	pos=lseek(fd,pos,0);
	if ( pos == -1 ) { 
	            t_err=LSEK_ERR;
		    return;
                   }
	num=read(fd,buffer,SIZE_B);
	if ( num == -1 ) {
		     t_err=READ_ERR;
		     return;
                   }
     }
	
  /* procedura che scrive un blocco di dati nel   
				       file system   */
  
  /* INPUT  : blocco da scrivere */
  /* OUTPUT : nessuno            */

     b_write(buffer,number) 
	     char *buffer;
	     long number;
     {
	long num,pos=dim_sb + sb.dim_li + (number-1)*SIZE_B;

	pos=lseek(fd,pos,0);
	if (pos == -1 ) {
		     t_err=LSEK_ERR;
		     return;
		    } 
	num=write(fd,buffer,SIZE_B);
	if (num == -1 ) {
		      t_err=WRIT_ERR;
		      return;
		      }
     }  
