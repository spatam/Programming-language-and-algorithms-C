program espressione1(input,output);

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
 head,lista,tail:punt;
 root:tree;
 n,i,j,num:integer;
 ris:char;
 operatori,operandi:insiemi;
 espr,espr1:string;

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

procedure ins_coda(x:char;var head,tail:punt);
var node:punt;
begin
 new(node);
 node^.info:=x;
 node^.next:=nil;
 if head=nil then
  begin
   head:=node;
   tail:=node;
  end
 else
  begin
   tail^.next:=node;
   tail:=node;
  end
end;{ins_coda}

procedure getnode(n:char;var root:tree);{questa procedura serve per creare}
var node:tree;                          {un nuovo nodo dell'albero}
begin
 new(node);
 node^.info:=n;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;{getnode}

procedure make_tree(var root:tree;var head:punt);{questa procedura mi serve}
var n:char;                                      {per creare nuovo albero BST}
begin
 if head<>nil then
  begin
   pop(n,head);
   getnode(n,root);
   if n in operatori then
    begin
     make_tree(root^.right,head);
     make_tree(root^.left,head);
    end
  end
end;{make_tree}

procedure postorder(root:tree);
begin
 if root<>nil then
  begin
   postorder(root^.left);
   postorder(root^.right);
   write(root^.info);
  end
end;{postorder}

procedure preorder(root:tree);
begin
 if root<>nil then
  begin
   write(root^.info);
   preorder(root^.left);
   preorder(root^.right);
  end
end;{preorder}

procedure inorder(root:tree);{questa procedura mi serve perche'}
begin                        {attraversando la espressione in inorder}
 if root<>nil then           {verifico la correttezza dell'albero}
  begin
   if root^.info in operatori then write('(');
   inorder(root^.left);
   write(root^.info);
   inorder(root^.right);
   if root^.info in operatori then write(')');
  end
end;{inorder}

procedure fine;
begin
 writeln('Termine momentaneo');
end;{fine}

begin{main program}
 root:=nil;
 head:=nil;
 operandi:=['a'..'e'];
 operatori:=['*','/','+','-'];
 repeat
 clrscr;
 writeln;
 writeln('1  Inserimento formula postfissa');{inserirla con push}
 writeln('2  Inserimento formula prefissa');{inserirla con ins_coda}
 writeln('3  Costruisci l''albero B.S.T per formule postfisse');
 writeln('4  Costruisci l''albero B.S.T per formule prefisse');
 writeln('5  Forma prefissa ');
 writeln('6  Forma infissa ');
 writeln('7  Forma postfissa ');
 writeln('8  Fine');
 write('Inserire una scelta per il menu'': ');readln(num);
 case num of
  1:begin
     writeln('Inserire una espressione aritmetica in forma ');
     write('postfissa che finisca con un punto ->');
     readln(espr);
     i:=1;
     while espr[i]<>'.' do
      begin
       if espr[i]<>'.' then push(espr[i],head);
       i:=i+1;
      end;
    readln;
    end;
  2:begin
     writeln('Inserire una espressione aritmetica in forma ');
     write('prefissa che finisca con un punto ->');
     readln(espr1);
     j:=1;
     while espr1[j]<>'.' do
      begin
       if espr1[j]<>'.' then ins_coda(espr1[j],lista,tail);
       j:=j+1;
      end;
    readln;
    end;
  3:make_tree(root,head);
  4:make_tree(root,lista);
  5:begin
     write('Forma prefissa ');
     preorder(root);
     readln;
    end;
  6:begin
     write('Forma infissa ');
     inorder(root);
     readln;
    end;
  7:begin
     write('Forma postfissa ');
     postorder(root);
     readln;
    end;
  8:fine;
 end;
 until num=8;
end.