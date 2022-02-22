# include "def.h"
# include "def/msg.h"   

    int flag;

    server() {
        int *pint,num,i,pid,t_oper;
        char *buffe;
	extern cleanup();

        for (i=0; i<20;i++)
                signal(i,cleanup);
        msgid_a = msgget(MSGKEY_A,0777 | IPC_CREAT);
        msgid_r = msgget(MSGKEY_R,0777 | IPC_CREAT);

	flag =FALSE;

        for (;;) 
        {
          msgrcv(msgid_a,&msg,20,1,0);
          if ( flag ==  TRUE ) break; 

            pint=(int *) msg.mtext;         
            pid=pint[0];
	    setuid(pint[1]);
	    setgid(pint[2]);
	    dir_cor=pint[3];
            t_oper=pint[4];

            msg.mtype = pid;
	    t_err=NOT_ERR;
            
	    switch(t_oper) {

            case CREAT: {
                  msgrcv(msgid_a,&msg,82,pid,0);
                  dati=(p_msg) msg.mtext;
                  
                  pint=(int *) msg.mtext;
                  *pint=my_creat(dati->nome,dati->info);
		  pint[1]=t_err;
                  msgsnd(msgid_r,&msg,8,0);
		  break;
                  }
            case MKNOD: {
		 msgrcv(msgid_a,&msg,82,pid,0);
		 dati=(p_msg) msg.mtext;

		 pint=(int *) msg.mtext;
		 my_mknod(dati->nome,dati->info);
		 *pint=t_err;
		 msgsnd(msgid_r,&msg,4,0);
		 break;
		 }






            case OPEN: {
                  msgrcv(msgid_a,&msg,82,pid,0);
                  dati=(p_msg) msg.mtext;
                  
                  pint=(int*) msg.mtext;
                  *pint=my_open(dati->nome,dati->info);
		  pint[1]=t_err;
                  msgsnd(msgid_r,&msg,8,0);
		  break;
                  }
            case READ: {
                  msgrcv(msgid_a,&msg,8,pid,0);
                  pint=(int *) msg.mtext;
                  num=pint[1];
                  
		  buff=( p_mbuf ) msg.mtext;
		  buff->count=my_read(pint[0],buff->buffer,pint[1]);
		  buff->fdes=t_err;
                  msgsnd(msgid_r,&msg,num+9,0);
		  break;
                }
            case WRITE: {
                  msgrcv(msgid_a,&msg,1024,pid,0);
                  buff=( p_mbuf ) msg.mtext; 

                  pint=(int *) msg.mtext;
                  *pint=my_write(buff->fdes,buff->buffer,buff->count);
                  pint[1]=t_err;
		  msgsnd(msgid_r,&msg,4,0);
		  break;
                }
            case CLOSE: {
                  msgrcv(msgid_a,&msg,4,pid,0); 
                  pint=(int *) msg.mtext;

                  my_close(*pint);
		  break;
                  }
            case LSEEK: {
		  msgrcv(msgid_a,&msg,12,pid,0);
		  pint=(int *) msg.mtext;

		  *pint=my_lseek(pint[0],pint[1],pint[2]);
                  msgsnd(msgid_r,&msg,4,0);
		  break;
                }
            case DUP: {
		  msgrcv(msgid_a,&msg,4,pid,0);
		  pint=(int *) msg.mtext;

		  f_table[*pint].count++;
		  break;
		  }







            case FORK: {
		  msgrcv(msgid_a,&msg,40,pid,0);
		  pint=(int *) msg.mtext;

		  for (i=0;i<10;i++) 
		    if (pint[i] != 0) 
				    f_table[pint[i]].count++;
                  break;
                }

            case CHDIR: {
		  msgrcv(msgid_a,&msg,82,pid,0);
		  dati=(p_msg) msg.mtext;

                  pint=(int *) msg.mtext;
		  pint[0]=my_chdir(dati->nome);
		  pint[1]=t_err;
		  msgsnd(msgid_r,&msg,8,0);
		  break;
               }
	    case LL: {
		  msgrcv(msgid_a,&msg,82,pid,0);
		  dati=(p_msg) msg.mtext;

		  pint=(int *) msg.mtext;
		  ll(dati->nome);
		  *pint=t_err;
		  msgsnd(msgid_r,&msg,4,0);
		  break;
               }
            default:break;
          }  /* end switch */
    }    /*  end for   */ 
 }


      cleanup()
      {    
      	   msgctl(msgid_a,IPC_RMID,0);
	   msgctl(msgid_r,IPC_RMID,0);
	   flag=TRUE;
      }	   
