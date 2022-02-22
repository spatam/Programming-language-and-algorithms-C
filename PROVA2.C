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

  printf("\n valore ritornato dalla creat %d \n",f);

  printf("devo scriver %s \n",buf);

  n=mwrite(f,buf,15);

  printf("valore ritornato dalla write %d \n",n);

  mclose(f);

  f=mopen(argv[1],OPEN_R);

  n=mlseek(f,200L,HEAD_F);
  printf("%ld \n",n);
  n=mlseek(f,100L,CURR_F);
  printf("%ld \n",n); 

  mclose(f);

  } 


