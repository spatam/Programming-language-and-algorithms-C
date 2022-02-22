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

  printf("utente reale %d \n",geteuid());
  f=setuid(100); 
  printf("utente settato %d %d\n",f,geteuid());
  
  f=mcreat(argv[1],0777);

  printf("\n valore ritornato dalla creat %d \n",f);

  pause();

  if ( f == -1 )  printf("errore tipo %d \n",t_err);
  else {

  printf("devo scriver %s \n",buf);

  n=mwrite(f,buf,15);

  printf("valore ritornato dalla write %d \n",n);

  mclose(f);

  f=mopen(argv[1],OPEN_R);

  printf("valore ritornato da open %d \n",f);

  n=mread(f,b,40);

  printf("valore ritonatoa da read %ld \n",n);

  printf("\n leggo %s \n",b);

  mclose(f);
  }

  } 


