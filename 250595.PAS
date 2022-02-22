program alberi(input,output);

type
 punt=^node;
 node=record
  info:char;
  next:punt;
 end;

 tree=^node1;
 node1=record
  info:char;
  left,right:tree;{*}
 end;

var
 i,n,m:integer;
 c,car:char;
 lista,lista1:punt;
 root,root1:tree;

procedure push(c:char;var head:punt);{OK}
var node:punt;
begin
 new(node);
 node^.info:=c;
 node^.next:=head;
 head:=node;
end;

procedure pop(var c:char;var head:punt);{OK*}
var node:punt;
begin
 node:=head;
 c:=node^.info;
 head:=node^.next;
 dispose(node);
end;

procedure getnode(c:char;var root:tree);{OK}
var node:tree;
begin
 new(node);
 node^.info:=c;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure make_tree(var head:punt;var root:tree);{OK}
var c:char;
begin
 if head<>nil then
  begin
   pop(c,head);
   getnode(c,root);
   make_tree(head,root^.left);
   make_tree(head,root^.right);
  end;
end;

procedure sostituisci(c:char;var root:tree;root1:tree);{OK*}
begin
 if root1<>nil then
  begin
   getnode(root1^.info,root);
   sostituisci(root^.info,root^.left,root1^.left);
   sostituisci(root^.info,root^.right,root1^.right);
  end
end;

procedure search(c:char;var root:tree);{OK*}
begin
 if root<>nil then
   if c=root^.info then sostituisci(c,root,root1)
    else if c<>root^.info then
                           begin
                            search(c,root^.left);
                            search(c,root^.right);
                           end;
end;

procedure inorder(root:tree);{OK}
begin
 if root<>nil then
  begin
   inorder(root^.left);
   write(root^.info,' ');
   inorder(root^.right);
  end;
end;

procedure init(num:integer;var head:punt);{OK}
var i:integer;car:char;
begin
 for i:=1 to num do
  begin
   write('Etichetta:');readln(car);
   push(car,head);
  end;
end;

begin {main program}
 lista:=nil;lista1:=nil;root:=nil;root1:=nil;
 writeln('PROGRAMMA ALBERI BINARI');
 writeln('***********************');
 write('Quante etichette vuoi inserire in A ? ');readln(n);
 init(n,lista);
 write('Quante etichette vuoi inserire in B ? ');readln(m);
 init(m,lista1);
 writeln('Creo albero A ..............');
 make_tree(lista,root);
 write('Attraverso e stampo A :');inorder(root);
 writeln;
 writeln('Creo albero b ..............');
 make_tree(lista1,root1);
 write('Attraverso e stampo B :');inorder(root1);
 writeln;writeln;
 write('Inserisci un carattere "x" generico:');readln(c);
 writeln('Sostituzione al posto di ',c,' in A dell''albero B :');
 search(c,root);
 write('Stampa del nuovo albero A : ');inorder(root);
 readln;
end.





