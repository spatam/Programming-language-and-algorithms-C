# include "lib.h"

  main(argc,argv)
      int argc;
      char *argv[];

 {
  int f,i,n;
  int buffer[10];
  char *buf,*b;

  buf="marionicosia ";
  b="";

  f=mcreat(argv[1],0777);

  getchar();

  printf("\n valore ritornato dalla creat %d \n",f);

  if ( f == -1 )  printf("errore tipo %d \n",t_err);
  else {

  printf("devo scriver %s \n",buf);

  n=mwrite(f,buf,15);
  getchar();

  printf("valore ritornato dalla write %d \n",n);

  mclose(f);
  getchar();

  f=mopen(argv[1],OPEN_R);

  printf("valore ritornato da open %d \n",f);

  n=mread(f,b,40);
  getchar();

  printf("valore ritonatoa da read %ld \n",n);

  printf("\n leggo %s \n",b);

  mclose(f);
  }

  } 


