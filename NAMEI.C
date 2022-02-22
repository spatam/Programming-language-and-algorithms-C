# include <stdio.h>
# include "def.h"

   /*  algoritmo MY_NAMEI che converte un pathname in un inode */ 
   /*  INPUT  : pathname   */
   /*  OUTPUT : l'inode relativo */

 inodeptr my_name(path_name)
             char *path_name;
  {
    int c=1,i,flag;
    long offset,off_bl,nb,nb_p=0;
    char *path,buffer[SIZE_B];
    inodeptr inode_l;
    st_dir entry;

    path=path_name;

    if ( *(path) == '/' )    /* se il pathname inizia con /=root.. */
       	{    
	   inode_l=my_iget(1);   /* .. la ricerca inizia dalla root.. */ 
	   path++;
        } 
	else  inode_l=my_iget(dir_cor);    /* .. altrimenti dalla dir
				           directory corrente       */
     c=*path;
     while ( c != '\0') {
	i=0;
	while ( ( (c=*(path++)) != '\0' ) && ( c != '/') )  
	    if (i<14) path_name[i++]=c;
        path_name[i]='\0';
                 
        if ( inode_l->in_disco.tipo != DIR ) {
				     t_err=PATH_ERR;
				     return (inode_l);
                                    }
        flag=FALSE;
	for (offset=0;offset<inode_l->in_disco.size_f; offset+=16)
	{ 
	  my_bmapr(inode_l,offset,&nb,&off_bl);
          if (nb != nb_p) {
			    b_read(buffer,nb);
			    nb_p=nb;
                          }
          memcpy(&entry,&(buffer[off_bl]),sizeof(entry));
          
	  if ( strcmp(entry.nome,path_name) == 0 ) {
		     my_iput(inode_l);
                     inode_l=my_iget(entry.inode_n);
		     flag=TRUE;
		     break;
                 }
        }
        if (flag != TRUE){  
                         t_err=FNFD_ERR;
			 break;
			 }
      }
      return (inode_l);
}
