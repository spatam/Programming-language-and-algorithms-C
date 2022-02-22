Program infix(input,output);
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
  left:tree;
  right:tree;
 end;
 insiemi=set of char;
var
 stack,head,lista:punt;
 root:tree;
 operandi,operatori:insiemi;
 formula:string;
 i:integer;

procedure push(n:char;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=n;
 node^.next:=head;
 head:=node;
end;

procedure pop(var n:char;var head:punt);
var node:punt;
begin
 node:=head;
 head:=head^.next;
 n:=node^.info;
 dispose(node);
end;

procedure getnode(n:char;var root:tree);
var node:tree;
begin
 new(node);
 node^.info:=n;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure print(head:punt);
begin
 while head<>nil do
 begin
  write(head^.info);
  head:=head^.next;
 end
end;

function ordine(n:integer;c:char):integer;
begin
 case c of
 '(':if n=1 then ordine:=4
            else ordine:=1;
 '*':ordine:=3;
 '/':ordine:=3;
 '+':ordine:=2;
 '-':ordine:=2;
 ')':ordine:=1;
 '$':ordine:=0;
 end
end;

function top(var head:punt):char;
begin
 top:=head^.info;
end;

procedure infix_prefix(x:integer;formula:string);
var
 a,b:char;
 i:integer;
begin
 head:=nil;
 push('$',head);
 for i:=1 to x do
 begin
  a:=formula[i];
  if a in operandi then push(a,lista)
  else
  begin
   b:=top(head);
   while ordine(1,a)<=ordine(2,b) do
   begin
    pop(b,head);
    if b in operatori then push(b,lista);
    b:=top(head);
   end;
   if a<>')' then push(a,head);
  end
 end;
 while top(head)<>'$' do
 begin
  pop(b,head);
  if b in operatori then push(b,lista);
 end
end;

procedure inorder(root:tree);
begin
 if root<>nil then
 begin
  if root^.info in operatori then write('(');
  inorder(root^.left);
  write(root^.info);
  inorder(root^.right);
  if root^.info in operatori then write(')');
 end
end;

procedure make_tree(var root:tree;var head:punt);
var n:char;
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
end;

function count(formula:string):integer;
var i:integer;
begin
 i:=1;
 while formula[i]<>'.' do i:=i+1;
 count:=i;
end;

procedure cambio(lista:punt;var stack:punt);{<----- modifica - eliminare }
begin
 while lista<>nil do
 begin
  push(lista^.info,stack);
  lista:=lista^.next;
 end
end;

begin {main program}
clrscr;
 head:=nil;
 lista:=nil;
 operatori:=['*','/','+','-'];
 operandi:=['a'..'h'];
 write('Inserisci una formula in forma infissa che finisca con un punto:');readln(formula);
 i:=count(formula);
 infix_prefix(i-1,formula);
 write('Forma preorder:');print(lista);writeln;
 cambio(lista,stack);
 write('Forma postorder:');print(stack);writeln;
 writeln('Creo albero B.S.T.');make_tree(root,lista);
 inorder(root);
readln;
end.

