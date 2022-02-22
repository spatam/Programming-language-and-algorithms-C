# include "lib.h"

 int fdrd,fdwt,a;
 char c;

 main(argc,argv)
      int argc;
      char *argv[];
 {
   if (argc != 3) exit();

   if ((fdrd = mopen(argv[1],OPEN_R)) == -1 ) exit();

   if ((fdwt = mcreat(argv[2],0777)) == -1 ) exit();

   printf("open e creat esegutite \n");

   if ((a=mfork())==0) printf("figlio \n");
       else printf("padre mio figlio ha pid %d \n",a);
   rdwrt();

   exit();
 }

 rdwrt ()
 {
    for (;;)
    {
       if (mread(fdrd,&c,1) != 1)
	  return ;
       printf("sono %d a leggere il carattere %c \n",a,c);
       mwrite(fdwt,&c,1);
    }
 }

