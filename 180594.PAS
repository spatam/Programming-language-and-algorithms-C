program immersione2(input,output);
uses crt;
type
 punt1=^node1;
 node1=record
  info:integer;
  next:punt1;
 end;
 punt2=^node2;
 node2=record
  info:punt1;
  next:punt2;
 end;

var
 head,lista:punt1;
 headlist:punt2;

procedure push(x:integer;var head:punt1);
var node:punt1;
begin
 new(node);
 node^.info:=x;
 node^.next:=head;
 head:=node;
end;

function pop(var head:punt1):punt1;
var node:punt1;
begin
 node:=head;
 head:=head^.next;
 node^.next:=nil;
 pop:=node;
end;

procedure print(head:punt1);
begin
 while head<>nil do
 begin
  write(head^.info);
  head:=head^.next;
  if head=nil then write('.') else write(',');
 end;
end;

procedure printlist(headlist:punt2);
begin
 while headlist<>nil do
 begin
  print(headlist^.info);
  headlist:=headlist^.next;
 end;
end;

procedure insertlist(head:punt1;var headlist:punt2);
var node:punt2;
begin
 new(node);
 node^.info:=head;
 node^.next:=headlist;
 headlist:=node;
end;

procedure ins_coda(node:punt1;var head,tail:punt1);
begin
 if head=nil then
 begin
  head:=node;
  tail:=node;
 end
 else
 begin
  tail^.next:=node;
  tail:=node;
 end;
end;

procedure insert(x:integer;var head:punt1);
begin
 if head=nil then push(x,head)
 else if x<head^.info then push(x,head)
 else if x>head^.info then insert(x,head^.next);
end;

function merge(node1,node2:punt1):punt1;
var head,tail,nodo:punt1;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
 if (node1^.info<node2^.info) then
 begin
  nodo:=pop(node1);
  ins_coda(nodo,head,tail);
 end
 else
 begin
  nodo:=pop(node2);
  ins_coda(nodo,head,tail);
 end;
 while (node1<>nil) do
 begin
  nodo:=pop(node1);
  ins_coda(nodo,head,tail);
 end;
 while(node2<>nil) do
 begin
  nodo:=pop(node2);
  ins_coda(nodo,head,tail);
 end;
 merge:=head;
end;

function immersione(headlist:punt2):punt1;
var
 lista:punt1;
 node:punt2;
 i:integer;
begin
 lista:=nil;
 node:=headlist;
 while node<>nil do
 begin
  lista:=merge(node^.info,lista);
  node:=node^.next;
 end;
 immersione:=lista;
end;

procedure ins(var headlist:punt2;var head:punt1);
var i,j,x,m,n,num:integer;
begin
 write('Quante liste vuoi inserire ? ');readln(n);
 for i:=1 to n do
 begin
  insertlist(nil,headlist);
  writeln('Inserimento ',i,'ø lista -->');
  write('Quanti numeri ? ');readln(m);
  for j:=1  to m do
  begin
   write('Numero:');
   readln(x);
   insert(x,headlist^.info);
  end;
 end;
end;

begin {main program}
clrscr;
 headlist:=nil;
 head:=nil;lista:=nil;
 ins(headlist,head);
 lista:=immersione(headlist);
 writeln;
 write('Stampa lista unica:');print(lista);
readln;
end.