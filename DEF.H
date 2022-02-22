# include "def_cost.h"

  typedef struct{	       /* struttura del super_blocco */
	short flag;
	long dim_f;
	long dim_li;
	short n_ifree;
	short l_ifree[F_LIST];
	short next_i;
	short n_bfree;
	short next_b;
	long l_bfree[IND];
	}st_blocco;

  typedef struct dinode{     /* struttura dell' inode  su disco */
	short uid;
	short gid;
	short tipo;
	short perms;
	long atime;
	long mtime;
	long minode;
	long size_f;
	long n_link;
	long table[D_TABLE];
	} st_dinode;
  
  typedef struct sinode *inodeptr;

  typedef struct sinode {          /* struttura inode in memoria */
	st_dinode in_disco;
	short stato;
	short inode_n;
	inodeptr nx_code;
	inodeptr lt_code;
	inodeptr nx_list;
	inodeptr lt_list;
	short rif_n;
	} st_inode;

 typedef struct{
	short count;	   /*  struttura della file table */
	long  offset;
	short mode;
	inodeptr p_inode;
	} st_ftable;

 typedef struct sdir{
        short inode_n;
	char  nome[14];
        }st_dir;

# include "def_var.h" 
