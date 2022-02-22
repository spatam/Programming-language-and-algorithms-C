program ordina(input,output);
uses crt;
type
 tree=^node;
 node=record
  info:integer;
  left:tree;
  right:tree;
 end;
 punt=^node1;
 node1=record
  info:tree;
  next:punt;
 end;

var
 i,n,num:integer;
 root:tree;

procedure getnode(x:integer;var root:tree);
var node:tree;
begin
 new(node);
 node^.info:=x;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;{getnode}

procedure insert(x:integer;var root:tree);
begin
 if root=nil then getnode(x,root)
 else if x<root^.info then insert(x,root^.left)
 else if x>root^.info then insert(x,root^.right);
end;{insert}

procedure inorder_d(root:tree);
begin
 if root<>nil then
  begin
   inorder_d(root^.right);
   write(' ',root^.info);
   inorder_d(root^.left);
  end
end;{inorder}

function top(head:punt):tree;
begin
 top:=head^.info;
end;

procedure pop(var x:tree;var head:punt);
var nodo:punt;
begin
 if head<>nil then
               begin
                  nodo:=head;
                  head:=head^.next;
                  x:=nodo^.info;
                  dispose(nodo);
               end
end;

procedure push(x:tree;var head:punt);
var nodo:punt;
begin
 new(nodo);
 nodo^.info:=x;
 nodo^.next:=head;
 head:=nodo;
end;

procedure itera_inorder(root:tree);
var
 head:punt;
 nodo:tree;
begin
 head:=nil;
 push(root,head);
 while head<>nil do
   begin
    nodo:=top(head);
    while nodo<>nil do
      begin
        nodo:=nodo^.left;
        if nodo<>nil then push(nodo,head);
      end;
    repeat
      if head<>nil then
        begin
          pop(nodo,head);
          write(' ',nodo^.info);
          if nodo^.right<>nil then push(nodo^.right,head);
       end;
    until (head=nil) or (nodo^.right<>nil)
   end;
   writeln
end; { fine }

begin{main program}
 clrscr;
 write('Quanti numeri interi vuoi inserire ?');readln(num);
 for i:=1 to num do
  begin
   write('Inserisci un numero intero prego:');readln(n);
   insert(n,root);
  end;
 writeln('Creo albero B.S.T.   ');
 write('Ordine decrescente ricorsivo ->');inorder_d(root);
 writeln;
 write('Ordine crescente iterativo ->');itera_inorder(root);
 writeln;
readln;
end.