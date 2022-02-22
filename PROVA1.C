# include "lib.h"

  main(argc,argv)
      int argc;
      char *argv[];

 {
  int f,i,n;
  int buffer[10],buf[10];

  f=mcreat(argv[1],0777);

  printf("\n valore ritornato dalla creat %d \n",f);

  for (i=0;i<10;i++) buffer[i]=i;

  n=mwrite(f,buffer,sizeof(buffer));

  printf("valore ritornato dalla write %d \n",n);

  mclose(f);

  f=mopen(argv[1],OPEN_R);

  printf("valore ritornato da open %d \n",f);

  n=mread(f,buf,40);

  printf("valore ritonatoa da read %ld \n",n);

  for (i=0;i<10;i++) printf(" %d ",buf[i]);
  printf("\n letto \n");

  mclose(f);

  } 


