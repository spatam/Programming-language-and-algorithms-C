
# include "def.h"

  ls()
  { long offset,nb,off,i;
    char buffer[SIZE_B];
    st_dir entry;

    inodeptr root;

    root=my_iget(1);
 
    printf("stampa della radice \n");

    for (i=0;i<9;i++) printf("posto %d valore %ld \n",i,root->in_disco.table[i]);

    printf(" \n contenuto della directory \n");

    printf("size %ld \n",root->in_disco.size_f);

    for (offset=0;offset<root->in_disco.size_f;offset+=16)
    {
     my_bmapr(root,offset,&nb,&off);

     if (nb != 0)
       {
       b_read(buffer,nb);
       memcpy(&entry,&(buffer[off]),16);
       printf("                          %ld %s %d \n",offset,entry.nome,entry.inode_n);
       }
     }
   }
      

