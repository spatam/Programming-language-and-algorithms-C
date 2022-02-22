program immersione1(input,output);
uses crt;
type
 punt=^node;
 node=record
  info:integer;
  next:punt;
 end;
 vettore=array [1..10] of punt;
var
 v:vettore;
 head,lista:punt;
 n:integer;

procedure push(x:integer;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=x;
 node^.next:=head;
 head:=node;
end;

procedure insert(x:integer;var head:punt);
begin
 if head=nil then push(x,head)
 else if x<head^.info then push(x,head)
 else if x>head^.info then insert(x,head^.next);
end;

procedure print(head:punt);
begin
 while head<>nil do
 begin
  write(head^.info,' ');
  head:=head^.next;
 end
end;

function immersione(n:integer;var v:vettore):punt;
var
 lista,node:punt;
 i:integer;
begin
 lista:=nil;
 for i:=1 to n do
 begin
  node:=v[i];
  while node<>nil do
  begin
   insert(node^.info,lista);
   node:=node^.next;
  end;
 end;
 immersione:=lista;
end;

procedure ins(var n:integer);
var i,j,m,num:integer;
begin
 write('Quante liste vuoi inserire ');readln(n);
 for i:=1 to n do
 begin
  writeln('Inserire la ',i,'ø lista -->');
  write('Quanti numeri vuoi inserire ? ');readln(num);
  for j:=1 to num do
  begin
   write('Numero:');
   readln(m);
   insert(m,v[i]);
  end
 end;
end;

begin {main program}
clrscr;
head:=nil;lista:=nil;
ins(n);
lista:=immersione(n,v);
write('Immersione liste in una unica ordinata: ');print(lista);
readln;
end.