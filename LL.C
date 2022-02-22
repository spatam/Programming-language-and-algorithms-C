# include <time.h>
# include "def.h"

   ll(nome)
      char *nome;

  { long offset,nb,off,i;
    char buffer[SIZE_B],*data,*tipo;
    st_dir entry;
    inodeptr inode,c;

    inode=my_name(nome);

    if (inode->in_disco.tipo != DIR) t_err=FNFD_ERR;

    if (t_err == NOT_ERR) {

    printf(" \n stampa della directory %s  \n \n",nome);

    for (offset=0L;offset<inode->in_disco.size_f;offset+=16)
    {
     my_bmapr(inode,offset,&nb,&off);

     if (nb != 0)
       {
       b_read(buffer,nb);
       memcpy(&entry,&(buffer[off]),16);
       c=my_iget(entry.inode_n);
       data=asctime(localtime(&(c->in_disco.atime)));
       if ( c->in_disco.tipo == DIR ) tipo="  DIR  ";
				else  tipo="REGULAR";
       printf(" %4d %4d %10ld %7s",c->in_disco.uid,c->in_disco.gid,c->in_disco.size_f,tipo);
       printf("%14s %s \n",entry.nome,data);
       my_iput(c);
       }
     }
    }
    my_iput(inode);
   }
      

