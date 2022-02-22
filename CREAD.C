# include "lib.h"

  main(argc,argv)
       int argc;
       char *argv[];
 {

  int r;

  printf("prima della chiamta errore %d \n",t_err);

  myknod(argv[1],0777);

  printf("valore di ritorno di mknod %d \n",t_err);
 }

