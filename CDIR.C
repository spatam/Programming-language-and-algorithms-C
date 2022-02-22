# include "lib.h"

  main(argc,argv)
       int argc;
       char *argv[];
  {
    int f;

    printf("dir corrente %d \n",dir_cor);

    f=mopen(argv[1],OPEN_RW);
    printf("ritorno da open %d errore %d \n",f,t_err);

    mchdir(argv[2]);
 
    printf("nuovo directory %d \n",dir_cor);

    f=mopen(argv[1],OPEN_RW);
    printf("ritorno da open 2 %d %d \n",f,t_err);

    close(f);
 }
