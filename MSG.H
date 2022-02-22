# include <sys/types.h>
# include <sys/ipc.h>
# include <sys/msg.h>
# include <stdio.h>

# define MSGKEY_A 75
# define MSGKEY_R 85

   typedef struct msgform
   {
        int mtype;
        char mtext[1024];
   } s_msg;

   typedef struct msg_dati *p_msg;

   struct msg_dati {
        short info;
        char nome[80];
   } smsg;

   typedef struct msg_buffer *p_mbuf;

   typedef struct msg_buffer {
          int fdes;
          long count;
          char buffer[1024];
   } smsg_b;
        
   int msgid_a;

   int msgid_r;

   p_msg dati;

   p_mbuf buff;

   s_msg msg;
