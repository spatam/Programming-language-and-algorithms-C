
  int fd;		/* file descriptor del file system */

  st_blocco sb;     /* struttura che contiene il super blocco in memoria */

  st_ftable f_table[MAXF];  /*  file table */

  inodeptr  h_list;  /*  testa della lista degli inode liberi in memoria */
  
  inodeptr coda[MAXT]; /* hash code che contiene gli inode attivati */

  inodeptr root;  /*  inode radice  */
  
  int t_err;    /*  tipo di errore, viene settato ad ogni procedura */

  short dir_cor; /* numero inode della directory corrente del processo 
		             che richiede l'utilizzo del file system  */

  int next_entry; /* prossima entry libera nella file table */
