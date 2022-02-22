# include <stdio.h>
# include <time.h>
# include "def.h"

  set_inode(inode,tipo_f)
	    struct dinode *inode;
	    short tipo_f;
  {     
	time_t *ora;

        inode->uid=getuid();
        inode->gid=getgid(); 
	inode->tipo=tipo_f;
	inode->perms=PERMS;
	inode->size_f=0;
	inode->n_link=1;

	ora=(time_t *) malloc(sizeof(time_t));
	time(ora);

	inode->atime=inode->mtime=inode->minode=*ora;
  }
