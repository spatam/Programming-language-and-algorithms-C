
# define  FALSE  0    /* valori booleani per variabili di tipo flag */
# define  TRUE   1

# define  NEW     0
# define  REGULAR 1    /*  tipi di file : non usato,normale,directory */
# define  DIR     2

# define  PERMS  0777		/* permessi di accesso al file system */

# define  SIZE_B  512 /* dimensione del blocco logico del file system */
# define  N_BLOC  6015 /* numero di blocchi del file system */ 
# define  NFILE   32 /* numero massimo di file che il f_s puo'contenere */
# define  MAXF    20 /* numero massimo di file in memoria  */
# define  MAXT    7 /* dimensione del hash code        */
# define  IND     128 /* numero di inidirizzi per ogni blocco   */
# define  F_LIST  10 /* taglia della lista di inode liberi nel s_blocco */
# define  D_TABLE 9  /* dimensione della tabella dei contenuti */

	 /*  tipi di errore durante l'esecuzione, la variabile globale
	       t_err viene settata ad uno di questi valori             */

# define  NOT_ERR  0   /* nessun errore                  */  
# define  PATH_ERR 1   /* path errato                    */     
# define  FNFD_ERR 2   /* file non trovato               */
# define  FDIR_ERR 3   /* file di directory              */
# define  FNTR_ERR 4   /* impossibile troncare il file   */
# define  LSEK_ERR 5   /* errore in lseek del file       */
# define  READ_ERR 6   /* errore in read del file        */
# define  WRIT_ERR 7   /* errore in write del file       */
# define  ACCN_ERR 8   /* operazione non conforme alla open */
# define  FULL_ERR 9   /* raggiunto il numero massimo di file in memoria */
# define  FLFS_ERR 10  /* spazio su disco insufficente   */  
# define  LFUL_ERR 11  /* Lista inode vuota in memoria   */
# define  FMAX_ERR 12  /* lista inode vuota nel disco    */

# include "oper.h"
