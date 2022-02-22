# include "lib.h"

  main(argc,argv)
       int argc;
       char *argv[];	
  {
      int i,j,num;
      char *buf1,*buf2;

      buf1=(char *) malloc(1);
      buf2=(char *) malloc(1);

      i=mopen(argv[1],OPEN_R);
      printf("open %d \n",i);
      j=mdup(i);
      printf("dup %d \n",j); 

      num=mread(i,buf1,10);
      printf("leggo %ld da open %s \n",num,buf1);
      num=mread(j,buf2,10);
      printf("leggo %ld da dup %s \n",num,buf2);
      mclose(i);

      num=mread(j,buf2,10);
      printf("leggo %d da dup dopo close %s \n",num,buf2);
  }
