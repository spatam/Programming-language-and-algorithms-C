# include "def.h"
# include <string.h>

 /* Algoritmo MY_OPEN per accedere ad un file esistente */

 /* INPUT  : nome del file (PATH),tipo di apertura (FLAG)
    OUTPUT : descrittore del file (F_DS)    */

    int my_open(path,flag)
                char *path;
                short flag;
    {
      inodeptr o_inode;
      int next;

      o_inode=my_name(path); /* converte il nome in un inode */
      if (o_inode->in_disco.tipo != REGULAR ) t_err=FDIR_ERR; 
      if (t_err != 0) {
                 my_iput(o_inode);
                 return(-1);
               }
      if ( (next=search_entry()) == -1 )  /* cerca una entry libera */
	                 return (-1);     /*  nella file table */
      f_table[next].count=1;
      f_table[next].offset=0;
      f_table[next].mode=flag;
      f_table[next].p_inode=o_inode;

      return (next);
    }

                      /*  Algoritmo LSEEK  */
   /* Modifica la posizione del puntatore di lettura-scrittura
   /* del descrittore file specificato e restituisce il nuovo valore */

   long my_lseek(fdes,offset,rifer)
		 int fdes;
		 long offset;
		 short rifer;
  {
    if (rifer == HEAD_F) f_table[fdes].offset=offset;
       else if (rifer == CURR_F) f_table[fdes].offset +=offset;
       else f_table[fdes].offset=f_table[fdes].p_inode->in_disco.size_f + offset;
   
   return(f_table[fdes].offset);
  }
    /* Procedura che cerca un entry libera nella file_table */

    int search_entry()
    { 
      while ( next_entry < MAXF )
	 if ( f_table[++next_entry].count == 0) return next_entry;
      t_err=FULL_ERR;
      return (-1);
    }






                     /* Algoritmo MY_READ */
    /* legge dal file indicato da FDES tanti byte quanti indicati da
       NUMERO e li trasferisce in BUFFER;     
       restituisce i byte realmente letti;              */

    /* INPUT  : FDES - file descriptor;
                BUFFER - indirizzo utente dove trasferire 
                         i byte letti;
                NUMERO - numero di byte da leggere;
       OUTPUT : numero di byte realmente letti   */

       long my_read(fdes,buffer,numero)
                   int fdes;
                   char *buffer;
                   long numero;
       {
         inodeptr r_inode=f_table[fdes].p_inode; 
         long nb,off_bl,offset,c,i=0;
	 char *p;
         char buff[SIZE_B];
         
         t_err=NOT_ERR;

       if ((f_table[fdes].mode !=OPEN_R) && (f_table[fdes].mode !=OPEN_RW))
                  { t_err=ACCN_ERR; 
		    return (-1);
                  }
         offset=f_table[fdes].offset;
         while ((numero > 0) && (offset<r_inode->in_disco.size_f))
              {  
                 my_bmapr(r_inode,offset,&nb,&off_bl);
                 c=min(numero,SIZE_B-off_bl);
                 if (nb != 0 ) {
                            b_read(buff,nb);
			    memcpy(buffer+i,&(buff[off_bl]),c);
                        }
                 numero -=c;
                 offset +=c;
                 i +=c;
              }
         if (i==0) return (-1);
	 *(buffer+i)='\0';
         f_table[fdes].offset =offset;
         return (i);
      }














                        /*  Algoritmo WRITE  */
      /* scrive nel file indicato dal descrittore fdes un numero
         NUMBER di byte dall'indirizzo utente buffer ;
         restituisce il numero di byte realmente scritti  */

      /* INPUT  : FDES - file descriptor;
                  BUFFER - indirizzo utente dove prendere
                           i dati da scrivere;
                  NUMBER - numero di byte da scrivere;
         OUTPUT : numero di byte realmente scritti   */
     
         long my_write(fdes,buffer,number)
                       int fdes;
                       char *buffer;
                       long number;
       {
         inodeptr w_inode=f_table[fdes].p_inode; 
         long nb,off_bl,offset,c,i=0;
         char buff[SIZE_B];
         
	 t_err=NOT_ERR;

    if ((f_table[fdes].mode !=OPEN_W) && (f_table[fdes].mode != OPEN_RW))
                  {
		    t_err=ACCN_ERR;
		    return (-1);
                  } 
         offset=f_table[fdes].offset;
         while (number > 0) 
              {  
                 my_bmapw(w_inode,offset,&nb,&off_bl);
                 c=min(number,SIZE_B-off_bl);
                 if (off_bl != 0 ) 
                                   b_read(buff,nb);
                 memcpy(&(buff[off_bl]),buffer+i,c);
                 b_write(buff,nb);      
                 number -=c;
                 offset +=c;
                 i +=c;
              }
         if ( offset>w_inode->in_disco.size_f ) {
                        w_inode->in_disco.size_f=offset; 
                        w_inode->stato=TRUE;
                      }
         f_table[fdes].offset=offset; 		      
         return (i);
        }

         int min(a,b)
             int a,b;
         {
            if (a>b) return (b);
               else  return (a);
         }
            
	    
	    
	    
	    
	    
	               /* Algoritmo MY_CLOSE   */
  /* chiude un descrittore file ottenuto prima con una open o creat;
    Libera la entry nella file_table e rilascia l'inode in memoria  */

          /*  INPUT  :descrittore del file ( FDS) 
	      OUTPUT :nessuno                        */

       my_close(fds)
	     int fds;
       {
	 f_table[fds].count--; 
         if (f_table[fds].count == 0 ) { 
	                  my_iput(f_table[fds].p_inode);
	                  if (next_entry >= fds) next_entry=fds-1;
			  }
       }
