# include "lib.h"

  main(argc,argv)
      int argc;
      char *argv[];

 {
  int f,i,n;
  char b[50];

  b[0]=0;

  f=mopen(argv[1],OPEN_R);

  printf("valore ritornato da open %d \n",f);

  n=mread(f,b,40);

  printf("valore ritonatoa da read %ld \n",n);

  printf("\n leggo %s \n",b);

  mclose(f);
  } 


