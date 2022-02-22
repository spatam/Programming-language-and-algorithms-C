# include "oper.h"  
# include "msg.h"

  int mcreat(nome,perms)
        char *nome;
        short perms;
  {
   int *num,pid=getpid();

   actung(pid,CREAT);

   msg.mtype =pid;
   dati=( p_msg ) msg.mtext;
   dati->info=perms;
   memcpy(&(dati->nome),nome,80);

   msgsnd(msgid_a,&msg,82);
   msgrcv(msgid_r,&msg,8,pid,0);

   num=(int *)msg.mtext;
   t_err=num[1];

   if (*num == -1) return (-1);

   if( (entry=s_entry()) == -1) return (-1);
   fd_table[entry]=*num;
   return(entry);
  }

   myknod(nome,perms)
	   char *nome;
	   short perms;
 {
   int *num,pid=getpid();

   actung(pid,MKNOD);

   msg.mtype =pid;
   dati=( p_msg ) msg.mtext;
   dati->info=perms;
   memcpy(&(dati->nome),nome,80);

   msgsnd(msgid_a,&msg,82);
   msgrcv(msgid_r,&msg,4,pid,0);

   num=(int *) msg.mtext;
   t_err=*num;
 }













  int mopen(nome,flag)
        char *nome;
        short flag;
  {
   int *num,pid=getpid();

   actung(pid,OPEN);

   msg.mtype =pid;
   dati=( p_msg ) msg.mtext;
   dati->info=flag;
   memcpy(&(dati->nome),nome,80);

   msgsnd(msgid_a,&msg,82);
   msgrcv(msgid_r,&msg,8,pid,0);

   num=(int *)msg.mtext;
   t_err=num[1];

   if ( *num == -1 ) return (-1);

   if ((entry=s_entry()) == -1) return (-1);
   fd_table[entry]=*num;
   return(entry);
  }

  int mwrite(fds,buffer,count)
        int fds;
        char *buffer;
        long count;
  {
        int *num,pid=getpid();

        if (fd_table[fds] == 0) return (-1);

        actung(pid,WRITE);

        msg.mtype=pid;
        buff=( p_mbuf ) msg.mtext;
        buff->fdes=fd_table[fds];
        buff->count=count;
        memcpy(buff->buffer,buffer,count);

        msgsnd(msgid_a,&msg,count+8,0);
        msgrcv(msgid_r,&msg,8,pid,0);

        num=(int *) msg.mtext;
	t_err=num[1];

        return(*num);
  }

  
  
  
  
  
  
  
  
  int mread(fds,buffer,count)
        int fds;
        char *buffer;
        long count;
  {
        int *pint,*num,pid=getpid();

        if (fd_table[fds] == 0) return (-1);

        actung(pid,READ);

        msg.mtype=pid;
	pint=( int * ) msg.mtext;
	pint[0]=fd_table[fds];
	pint[1]=count;

        msgsnd(msgid_a,&msg,8,0);
        msgrcv(msgid_r,&msg,count+9,pid,0);

        buff=( p_mbuf ) msg.mtext;
	t_err=buff->fdes;

	if (buff->count == -1 ) return (-1);
        
        memcpy(buffer,buff->buffer,buff->count+1);  

        return(buff->count);
  }
  mclose(fdes)
        int fdes;
  {
    int *pint,pid=getpid();

    if ( fd_table[fdes] == 0) return (-1);

    actung(pid,CLOSE);

    msg.mtype=pid;
    pint=(int *) msg.mtext;
    *pint=fdes;

    msgsnd(msgid_a,&msg,4,0);

    fd_table[fdes]=0;
    if ( fdes <= entry ) entry=--fdes;

    return;
  }












  mlseek(fdes,offset,rifer)
	 int fdes;
	 long offset;
	 short rifer;
  {
    int *pint,pid=getpid();

    if (fd_table[fdes] == 0 ) return (-1);

    if ((rifer != HEAD_F) && (rifer != CURR_F) && (rifer != END_F))
			    return  (-1);
    actung(pid,LSEEK);

    msg.mtype=pid;
    pint=(int*) msg.mtext;
    pint[0]=fdes;
    pint[1]=offset;
    pint[2]=rifer;

    msgsnd(msgid_a,&msg,12,0);
    msgrcv(msgid_r,&msg,4,pid,0);

    return(*pint);
  }
  int mdup(oldfd)
	   int oldfd;
  {
   int *pint,pid=getpid();
   
   if (fd_table[oldfd] == 0 ) return (-1);

   actung(pid,DUP);

   msg.mtype=pid;
   pint=(int *) msg.mtext;
   *(pint)=oldfd;

   msgsnd(msgid_a,&msg,4,0);

   if ((entry=s_entry()) == -1) return (-1);
   fd_table[entry]=fd_table[oldfd];
   return(entry);
 }
 int mfork()
 {
   int *pint,i,pid=getpid();

   actung(pid,FORK);

   msg.mtype=pid;
   pint=(int *) msg.mtext;
   for (i=0;i<FILE_MAX ;i++) 
	 pint[i]=fd_table[i];
   
   msgsnd(msgid_a,&msg,4*FILE_MAX,0);
 
   return fork();
 }

 mchdir(nome)
	char *nome;
 {
   int *pint,pid=getpid();

   actung(pid,CHDIR);

   msg.mtype=pid;
   dati=(p_msg) msg.mtext;
   memcpy(&(dati->nome),nome,80);

   msgsnd(msgid_a,&msg,82);
   msgrcv(msgid_r,&msg,8,pid,0);

   pint=(int *) msg.mtext;
   t_err=pint[1];
   dir_cor=pint[0];
 }

 mll(nome)
     char *nome;
 {
   int *pint,pid=getpid();

   actung(pid,LL);

   msg.mtype=pid;
   dati=(p_msg) msg.mtext;
   memcpy(&(dati->nome),nome,80);

   msgsnd(msgid_a,&msg,82);
   msgrcv(msgid_r,&msg,4,pid,0);

   pint=(int *) msg.mtext;
   t_err=*pint;
 }
    
  actung(pid,t_oper)
         int pid;
         int t_oper;
  {
    int *pint;

    msgid_a=msgget(MSGKEY_A,0777);
    msgid_r=msgget(MSGKEY_R,0777);

    msg.mtype =1;
    pint= (int *) msg.mtext;
    pint[0]=pid;
    pint[1]=geteuid();
    pint[2]=getegid();
    pint[3]=dir_cor;
    pint[4]=t_oper;

    msgsnd(msgid_a,&msg,20,0);
  }
 



  int s_entry()
  {
	while (entry < FILE_MAX )
	      if (fd_table[++entry] == 0) return entry;
        return (-1);
  }

