program espressione(input,output);

uses crt;

type
 punt=^node;
 node=record
  info:char;
  next:punt;
 end;

 tree=^node1;
 node1=record
  info:char;
  left,right:tree;
 end;

 insiemi=set of char;
 car='a'..'e';

var
 ch:car;
 head,nod:punt;
 root:tree;
 n,i,num:integer;
 ris:char;
 operatori,operandi:insiemi;
 espr:string;

procedure push(n:char;var head:punt);{questa procedura mi serve per inserire}
var node:punt;                       {elementi in testa in uno stack}
begin
 new(node);
 node^.info:=n;
 node^.next:=head;
 head:=node;
end;{push}

procedure pop(var n:char;var head:punt);{questa procedura mi serve per}
var node:punt;                          {cancellarne gli elementi in testa}
begin
 node:=head;
 head:=node^.next;
 n:=node^.info;
 dispose(node);
end;{pop}

procedure getnode(n:char;var root:tree);
var node:tree;
 begin
  new(node);
  node^.info:=n;
  node^.left:=nil;
  node^.right:=nil;
  root:=node;
 end;{getnode}

procedure insert(n:char;var root:tree);
 begin
 if root=nil then getnode(n,root)
 else if n<root^.info then insert(n,root^.left)
 else if n>root^.info then insert(n,root^.right)
end;{insert}

procedure crea_albero(var root:tree;var head:punt);
var n:char;
begin
 if head<>nil then
  begin
   pop(n,head);
   getnode(n,root);
   if n in operatori then
    begin
     crea_albero(root^.left,head);
     crea_albero(root^.right,head);
    end
  end
end;{crea_albero}

procedure inorder(root:tree);{questa procedura mi serve perche'}
begin                        {attraversando la espressione in inorder}
 if root<>nil then           {avremo la espressione in forma infix}
  begin
   inorder(root^.left);
   write(root^.info);
   inorder(root^.right);
  end
end;{inorder}

procedure fine;
begin
 writeln('Termine momentaneo');
end;{fine}

begin{main program}
 clrscr;
 root:=nil;
 head:=nil;
 operandi:=['a'..'e'];
 operatori:=['*','/','+','-'];
 repeat
 writeln;
 writeln('1 Inserimento formula');
 writeln('2 Costruisci l''albero B.S.T');
 writeln('3 Stampa Infissa');
 writeln('4 Fine');
 write('Inserire una scelta per il menu'': ');readln(num);
 case num of
  1:begin
     writeln('Inserire una espressinoe aritmetica in forma postfissa');
     write('che finisca con un punto ->');
     readln(espr);
     i:=1;
     while espr[i]<>'.' do
      begin
       if espr[i]<>'.' then push(espr[i],head);
       i:=i+1;
     end;
    end;
  2:crea_albero(root,head);
  3:inorder(root);
  4:fine;
 end;
 until num=4;
readln;
end.