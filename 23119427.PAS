program formula(input,output);

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
var
 operandi,operatori:insiemi;
 head:punt;
 root:tree;
 num:integer;

procedure push(n:char;var head:punt);
var
 node:punt;
begin
 new(node);
 node^.info:=n;
 node^.next:=head;
 head:=node;
end;

procedure pop(var n:char;var head:punt);
var
 node:punt;
begin
 node:=head;
 head:=node^.next;
 n:=node^.info;
 dispose(node);
end;

procedure ins_coda(n:char;var head,tail:punt);
var
 node:punt;
begin
 new(node);
 node^.info:=n;
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
end;

function ordine(n:integer;c:char):integer;
begin
 case c of
 '(':if n=1 then ordine:=4
            else ordine:=1;
 '*':ordine:=3;
 '/':ordine:=3;
 '-':ordine:=2;
 '+':ordine:=2;
 ')':ordine:=1;
 '$':ordine:=0;
 end
end;

function top(head:punt):char;
begin
 top:=head^.info;
end;

procedure infix_prefix(x:integer;formula:string);
var
 a,b:char;
 i:integer;
 lista:punt;
begin
 lista:=nil;
 head:=nil;
 push('$',lista);
 for i:=1 to x do
 begin
  a:=formula[i];
  if a in operandi then push(a,head)
  else
  begin
   b:=top(lista);
   while ordine(1,a)<=ordine(2,b) do
    begin
     pop(b,lista);
     if b in operatori then push(b,head);
     b:=top(lista);
    end;
   if a<>')' then push(a,lista);
  end;  {endelse}
 end; { endfor }
 while top(lista)<>'$' do
 begin
  pop(b,lista);
  if b in operatori then push(b,head);
 end
end;

procedure car_postfissa(formula:string;var head:punt);
var i:integer;
begin
 head:=nil;
 i:=1;
 while formula[i]<>'.' do
  begin
    push(formula[i],head);
    i:=i+1;
  end;
end;

procedure car_prefissa(formula:string;var head:punt);
var i:integer;
    tail:punt;
begin
 head:=nil;
 tail:=nil;
 i:=1;
 while formula[i]<>'.' do
  begin
    ins_coda(formula[i],head,tail);
    i:=i+1;
  end;
end;

procedure car_infissa(formula:string;var head:punt);
var i:integer;
begin
 i:=1;
 while formula[i]<>'.' do i:=i+1;
 infix_prefix(i,formula);
end;

procedure ins_formula(var head:punt);
var formula:string;
    ris:integer;
begin
 head:=nil;
 repeat
  clrscr;
  writeln('*********  INSERIMENTO FORMULA ********');
  writeln('1* Postfissa');
  writeln('2* Prefissa');
  writeln('3* Infissa');
  writeln;
  write('Inserisci una scelta:');
  readln(ris);
 until (ris=1) or (ris=2) or (ris=3);
 write('Inserisci la formula che finisca con un punto -> ');
 readln(formula);
 case ris of
  1:car_postfissa(formula,head);  {PS: head deve essere una lista }
  2:car_prefissa(formula,head);   {     in forma prefissa sempre }
  3:car_infissa(formula,head);    {     per poter fare make_tree }
 end;
end;

procedure getnode(n:char;var root:tree);
var
 node:tree;
begin
 new(node);
 node^.info:=n;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure make_tree(var root:tree;var head:punt);
var
 n:char;
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

procedure postorder(root:tree);
begin
 if root<>nil then
 begin
  postorder(root^.left);
  postorder(root^.right);
  write(root^.info);
 end
end;

procedure preorder(root:tree);
begin
 if root<>nil then
 begin
  write(root^.info);
  preorder(root^.left);
  preorder(root^.right);
 end
end;

procedure print(head:punt);
begin
 while head<>nil do
  begin
    write(head^.info);
    head:=head^.next
  end;
 writeln;
end;

begin{main program}
 root:=nil;
 operatori:=['*','/','+','-'];
 operandi:=['a'..'e'];
 repeat
  clrscr;
  writeln;
  writeln('1 Inserisci una formula');
  writeln('2 Stampa postfissa ');
  writeln('3 Stampa prefissa');
  writeln('4 Stampa infissa');
  writeln('5 Fine');
  write('Inserire una scelta del men— ');readln(num);
  case num of
  1:begin
     ins_formula(head);
     print(head);
     root:=nil;
     make_tree(root,head);
     inorder(root);
     readln;
    end;
  2:begin
     writeln('Stampa Formula in forma postfissa');
     postorder(root);
     readln;
    end;
  3:begin
     writeln('Stampa Formula in forma prefissa');
     preorder(root);
     readln;
    end;
  4:begin
     writeln('Stampa Formula in forma infissa');
     inorder(root);
     readln;
    end;
  5:writeln('Termine momentaneo');
 end;
 until num=5;
readln;
end.